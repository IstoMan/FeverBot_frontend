import 'package:dio/dio.dart';
import 'package:manifesto/common/core/utils/errors/exceptions.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';
import 'package:manifesto/common/resources/network_resources/api_endpoints.dart';
import 'package:manifesto/common/resources/network_resources/rest_client/rest_client.dart';
import 'package:manifesto/features/dashboard/data/datasources/remote/sse_chat_parser.dart';
import 'package:manifesto/features/dashboard/data/models/accept_request_model.dart';
import 'package:manifesto/features/dashboard/data/models/chat_history_model.dart';
import 'package:manifesto/features/dashboard/data/models/dashboard_model.dart';
import 'package:manifesto/features/dashboard/data/models/delete_member_model.dart';
import 'package:manifesto/features/dashboard/data/models/delete_member_request_model.dart';
import 'package:manifesto/features/dashboard/data/models/document_model.dart';
import 'package:manifesto/features/dashboard/data/models/family_model.dart';
import 'package:manifesto/features/dashboard/data/models/invite_model.dart';
import 'package:manifesto/features/dashboard/data/models/invite_request_model.dart';
import 'package:manifesto/features/dashboard/data/models/new_chat_model.dart';
import 'package:manifesto/features/dashboard/data/models/user_model.dart';
import 'package:manifesto/features/dashboard/domain/entities/accept_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/chat_stream_event.dart';
import 'package:manifesto/features/dashboard/domain/entities/delete_member_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/document_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/invite_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/send_chat_request_entity.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardModel> fetchDashboardData();

  Future<NewChatModel> startChat();

  Stream<ChatStreamEvent> streamChat(SendChatRequestEntity request);

  Future<FamilyModel> getFamily();

  Future<InviteModel> inviteMember(InviteRequestEntity request);

  Future<List<ChatHistoryModel>> getChats();

  Future<FamilyModel> acceptInvite(AcceptRequestEntity request);

  Future<DeleteMemberModel> deleteMember(DeleteMemberRequestEntity request);

  Future<UserModel> getUser();

  Future<List<DocumentModel>> getDocuments();

  Future<DocumentModel> uploadDocument(UploadDocumentRequestEntity request);

  Future<DocumentModel> getDocument(String docId);

  Future<DocumentDownloadEntity> downloadDocument(DocumentEntity document);

  Future<DocumentModel> analyzeDocument(DocumentEntity document);

  Future<void> deleteDocument(String docId);
}

class DashboardRemoteDataSourceImpl extends DashboardRemoteDataSource {
  final RestClient _restClient;
  final SseChatParser _sseParser;

  DashboardRemoteDataSourceImpl(
    this._restClient, {
    SseChatParser sseParser = const SseChatParser(),
  }) : _sseParser = sseParser;

  String _dioMessage(DioException dioError) {
    final data = dioError.response?.data;
    if (data is Map) {
      return data["detail"]?.toString() ??
          data["details"]?.toString() ??
          dioError.message ??
          "Unknown error";
    }
    return dioError.message ?? "Unknown error";
  }

  Never _throwDio(String action, DioException dioError, StackTrace stackTrace) {
    Log.warning(
      "DioException while $action",
      dioError,
      stackTrace,
    );
    throw APIException(
      message: _dioMessage(dioError),
      statusCode: dioError.response?.statusCode ?? -1,
    );
  }

  Never _throwUnexpected(String action, Object e, StackTrace stackTrace) {
    Log.warning(
      "Unexpected error while $action",
      e,
      stackTrace,
    );
    throw APIException(
      message: e.toString(),
      statusCode: -1,
    );
  }

  @override
  Future<DashboardModel> fetchDashboardData() async {
    try {
      final response = await _restClient.get(
        APIEndpoints.dashboardEndPoint,
      );
      return DashboardModel.fromJson(response);
    } on DioException catch (dioError, stackTrace) {
      _throwDio("fetching dashboard data", dioError, stackTrace);
    } catch (e, stackTrace) {
      _throwUnexpected("fetching dashboard data", e, stackTrace);
    }
  }

  @override
  Future<NewChatModel> startChat() async {
    try {
      final response = await _restClient.post(
        APIEndpoints.newChat,
      );
      return NewChatModel.fromJson(response);
    } on DioException catch (dioError, stackTrace) {
      _throwDio("fetching new chat", dioError, stackTrace);
    } catch (e, stackTrace) {
      _throwUnexpected("creating new chat", e, stackTrace);
    }
  }

  @override
  Stream<ChatStreamEvent> streamChat(SendChatRequestEntity request) async* {
    try {
      final body = await _restClient.postEventStream(
        APIEndpoints.sendChat(request.chatId),
        formData: FormData.fromMap({
          'message': request.message,
        }),
      );
      yield* _sseParser.parse(body);
    } on DioException catch (dioError, stackTrace) {
      Log.warning(
        "DioException while streaming chat",
        dioError,
        stackTrace,
      );

      final statusCode = dioError.response?.statusCode ?? -1;
      final message = dioError.response?.data is Map
          ? dioError.response?.data["details"]?.toString() ??
              dioError.response?.data["detail"]?.toString() ??
              dioError.message
          : dioError.message ?? "Unknown error";

      yield ChatStreamError(message ?? "Stream failed ($statusCode)");
    } catch (e, stackTrace) {
      Log.warning(
        "Unexpected error while streaming chat",
        e,
        stackTrace,
      );
      yield ChatStreamError(e.toString());
    }
  }

  @override
  Future<FamilyModel> getFamily() async {
    try {
      final response = await _restClient.get(
        APIEndpoints.getFamily,
      );
      return FamilyModel.fromJson(response);
    } on DioException catch (dioError, stackTrace) {
      final statusCode = dioError.response?.statusCode ?? -1;
      if (statusCode == 404) {
        // API uses 404 when the user is not in any family group.
        return FamilyModel(groupId: '', ownerId: '', members: const []);
      }
      _throwDio("getting family", dioError, stackTrace);
    } catch (e, stackTrace) {
      _throwUnexpected("getting family", e, stackTrace);
    }
  }

  @override
  Future<InviteModel> inviteMember(InviteRequestEntity request) async {
    final requestModel = InviteRequestModel.fromEntity(request);
    try {
      final response = await _restClient.post(
        APIEndpoints.inviteFamily,
        data: requestModel.toJson(),
      );
      return InviteModel.fromJson(response);
    } on DioException catch (dioError, stackTrace) {
      _throwDio("inviting member", dioError, stackTrace);
    } catch (e, stackTrace) {
      _throwUnexpected("inviting member", e, stackTrace);
    }
  }

  @override
  Future<List<ChatHistoryModel>> getChats() async {
    try {
      final response = await _restClient.get(
        APIEndpoints.getChats,
      );
      return (response as List<dynamic>? ?? [])
          .map((m) => ChatHistoryModel.fromJson(m as Map<String, dynamic>))
          .toList();
    } on DioException catch (dioError, stackTrace) {
      _throwDio("fetching chats", dioError, stackTrace);
    } catch (e, stackTrace) {
      _throwUnexpected("fetching chats", e, stackTrace);
    }
  }

  @override
  Future<FamilyModel> acceptInvite(AcceptRequestEntity request) async {
    final requestModel = AcceptRequestModel.fromEntity(request);
    try {
      final response = await _restClient.post(
        APIEndpoints.acceptInvite,
        data: requestModel.toJson(),
      );
      return FamilyModel.fromJson(
        response['family'],
      );
    } on DioException catch (dioError, stackTrace) {
      _throwDio("accepting invite", dioError, stackTrace);
    } catch (e, stackTrace) {
      _throwUnexpected("accepting invite", e, stackTrace);
    }
  }

  @override
  Future<DeleteMemberModel> deleteMember(
      DeleteMemberRequestEntity request) async {
    final requestModel = DeleteMemberRequestModel.fromEntity(request);
    try {
      final response = await _restClient.delete(
        APIEndpoints.deleteMember(
          requestModel.memberId,
        ),
      );
      return DeleteMemberModel.fromJson(response);
    } on DioException catch (dioError, stackTrace) {
      _throwDio("deleting member", dioError, stackTrace);
    } catch (e, stackTrace) {
      _throwUnexpected("deleting member", e, stackTrace);
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      final response = await _restClient.get(
        APIEndpoints.me,
      );
      return UserModel.fromJson(response);
    } on DioException catch (dioError, stackTrace) {
      _throwDio("getting user", dioError, stackTrace);
    } catch (e, stackTrace) {
      _throwUnexpected("getting user", e, stackTrace);
    }
  }

  @override
  Future<List<DocumentModel>> getDocuments() async {
    try {
      final response = await _restClient.get(
        APIEndpoints.documents,
      );
      return (response as List<dynamic>? ?? [])
          .map((m) => DocumentModel.fromJson(m as Map<String, dynamic>))
          .toList();
    } on DioException catch (dioError, stackTrace) {
      _throwDio("fetching documents", dioError, stackTrace);
    } catch (e, stackTrace) {
      _throwUnexpected("fetching documents", e, stackTrace);
    }
  }

  @override
  Future<DocumentModel> uploadDocument(
      UploadDocumentRequestEntity request) async {
    try {
      final formMap = <String, dynamic>{
        'file': await MultipartFile.fromFile(
          request.filePath,
          filename: request.filename,
        ),
        'analyze': request.analyze.toString(),
      };
      if (request.type != null && request.type!.isNotEmpty) {
        formMap['type'] = request.type;
      }
      final response = await _restClient.upload(
        APIEndpoints.documents,
        formData: FormData.fromMap(formMap),
      );
      if (response is Map<String, dynamic>) {
        return DocumentModel.fromJson(response);
      }
      if (response is Map) {
        return DocumentModel.fromJson(Map<String, dynamic>.from(response));
      }
      throw APIException(
        message: "Unexpected upload response",
        statusCode: -1,
      );
    } on APIException {
      rethrow;
    } on DioException catch (dioError, stackTrace) {
      _throwDio("uploading document", dioError, stackTrace);
    } catch (e, stackTrace) {
      _throwUnexpected("uploading document", e, stackTrace);
    }
  }

  @override
  Future<DocumentModel> getDocument(String docId) async {
    try {
      final response = await _restClient.get(
        APIEndpoints.document(docId),
      );
      return DocumentModel.fromJson(response as Map<String, dynamic>);
    } on DioException catch (dioError, stackTrace) {
      _throwDio("fetching document", dioError, stackTrace);
    } catch (e, stackTrace) {
      _throwUnexpected("fetching document", e, stackTrace);
    }
  }

  @override
  Future<DocumentDownloadEntity> downloadDocument(
      DocumentEntity document) async {
    try {
      final bytes = await _restClient.getBytes(
        APIEndpoints.documentDownload(document.id),
      );
      return DocumentDownloadEntity(
        filename: document.filename,
        bytes: bytes,
        contentType: document.contentType.isEmpty ? null : document.contentType,
      );
    } on DioException catch (dioError, stackTrace) {
      _throwDio("downloading document", dioError, stackTrace);
    } catch (e, stackTrace) {
      _throwUnexpected("downloading document", e, stackTrace);
    }
  }

  @override
  Future<DocumentModel> analyzeDocument(DocumentEntity document) async {
    try {
      final response = await _restClient.post(
        APIEndpoints.documentAnalyze(document.id),
      );
      final map = response is Map<String, dynamic>
          ? response
          : Map<String, dynamic>.from(response as Map);
      return DocumentModel.fromAnalyzeJson(map, existing: document);
    } on DioException catch (dioError, stackTrace) {
      _throwDio("analyzing document", dioError, stackTrace);
    } catch (e, stackTrace) {
      _throwUnexpected("analyzing document", e, stackTrace);
    }
  }

  @override
  Future<void> deleteDocument(String docId) async {
    try {
      await _restClient.delete(
        APIEndpoints.document(docId),
      );
    } on DioException catch (dioError, stackTrace) {
      _throwDio("deleting document", dioError, stackTrace);
    } catch (e, stackTrace) {
      _throwUnexpected("deleting document", e, stackTrace);
    }
  }
}
