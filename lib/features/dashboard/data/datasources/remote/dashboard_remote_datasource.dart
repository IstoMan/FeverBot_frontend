import 'package:dio/dio.dart';
import 'package:manifesto/common/core/utils/errors/exceptions.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';
import 'package:manifesto/common/resources/network_resources/api_endpoints.dart';
import 'package:manifesto/common/resources/network_resources/rest_client/rest_client.dart';
import 'package:manifesto/features/dashboard/data/models/accept_request_model.dart';
import 'package:manifesto/features/dashboard/data/models/chat_history_model.dart';
import 'package:manifesto/features/dashboard/data/models/dashboard_model.dart';
import 'package:manifesto/features/dashboard/data/models/delete_member_model.dart';
import 'package:manifesto/features/dashboard/data/models/delete_member_request_model.dart';
import 'package:manifesto/features/dashboard/data/models/family_model.dart';
import 'package:manifesto/features/dashboard/data/models/invite_model.dart';
import 'package:manifesto/features/dashboard/data/models/invite_request_model.dart';
import 'package:manifesto/features/dashboard/data/models/new_chat_model.dart';
import 'package:manifesto/features/dashboard/data/models/send_chat_model.dart';
import 'package:manifesto/features/dashboard/data/models/send_chat_request_model.dart';
import 'package:manifesto/features/dashboard/data/models/user_model.dart';
import 'package:manifesto/features/dashboard/domain/entities/accept_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/delete_member_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/invite_request_entity.dart';

import '../../../domain/entities/send_chat_request_entity.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardModel> fetchDashboardData();

  Future<NewChatModel> startChat();

  Future<SendChatModel> sendChat(SendChatRequestEntity request);

  Future<FamilyModel> getFamily();

  Future<InviteModel> inviteMember(InviteRequestEntity request);

  Future<List<ChatHistoryModel>> getChats();

  Future<FamilyModel> acceptInvite(AcceptRequestEntity request);

  Future<DeleteMemberModel> deleteMember(DeleteMemberRequestEntity request);

  Future<UserModel> getUser();
}

class DashboardRemoteDataSourceImpl extends DashboardRemoteDataSource {
  final RestClient _restClient;

  DashboardRemoteDataSourceImpl(this._restClient);

  @override
  Future<DashboardModel> fetchDashboardData() async {
    try {
      final response = await _restClient.get(
        APIEndpoints.dashboardEndPoint,
      );
      return DashboardModel.fromJson(response);
    } on DioException catch (dioError, stackTrace) {
      Log.warning(
        "DioException while fetching dashboard data",
        dioError,
        stackTrace,
      );

      final statusCode = dioError.response?.statusCode ?? -1;
      final message = dioError.response?.data is Map
          ? dioError.response?.data["details"]?.toString() ?? dioError.message
          : dioError.message ?? "Unknown error";

      throw APIException(message: message!, statusCode: statusCode);
    } catch (e, stackTrace) {
      Log.warning(
        "Unexpected error while fetching dashboard data",
        e,
        stackTrace,
      );

      throw APIException(
        message: e.toString(),
        statusCode: -1,
      );
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
      Log.warning(
        "DioException while fetching new chat",
        dioError,
        stackTrace,
      );

      final statusCode = dioError.response?.statusCode ?? -1;
      final message = dioError.response?.data is Map
          ? dioError.response?.data["details"]?.toString() ?? dioError.message
          : dioError.message ?? "Unknown error";

      throw APIException(message: message!, statusCode: statusCode);
    } catch (e, stackTrace) {
      Log.warning(
        "Unexpected error while creating new chat",
        e,
        stackTrace,
      );

      throw APIException(
        message: e.toString(),
        statusCode: -1,
      );
    }
  }

  @override
  Future<SendChatModel> sendChat(SendChatRequestEntity request) async {
    final requestModel = SendChatRequestModel.fromEntity(request);
    try {
      final response = await _restClient.post(
        APIEndpoints.sendChat(request.chatId),
        data: FormData.fromMap(requestModel.toJson()),
        contentType: "multipart/form-data",
      );
      return SendChatModel.fromJson(response);
    } on DioException catch (dioError, stackTrace) {
      Log.warning(
        "DioException while sending new chat",
        dioError,
        stackTrace,
      );

      final statusCode = dioError.response?.statusCode ?? -1;
      final message = dioError.response?.data is Map
          ? dioError.response?.data["details"]?.toString() ?? dioError.message
          : dioError.message ?? "Unknown error";

      throw APIException(message: message!, statusCode: statusCode);
    } catch (e, stackTrace) {
      Log.warning(
        "Unexpected error while sending new chat",
        e,
        stackTrace,
      );

      throw APIException(
        message: e.toString(),
        statusCode: -1,
      );
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
      Log.warning(
        "DioException while getting family",
        dioError,
        stackTrace,
      );

      final statusCode = dioError.response?.statusCode ?? -1;
      final message = dioError.response?.data is Map
          ? dioError.response?.data["details"]?.toString() ?? dioError.message
          : dioError.message ?? "Unknown error";

      throw APIException(message: message!, statusCode: statusCode);
    } catch (e, stackTrace) {
      Log.warning(
        "Unexpected error while getting family",
        e,
        stackTrace,
      );

      throw APIException(
        message: e.toString(),
        statusCode: -1,
      );
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
      Log.warning(
        "DioException while inviting member",
        dioError,
        stackTrace,
      );

      final statusCode = dioError.response?.statusCode ?? -1;
      final message = dioError.response?.data is Map
          ? dioError.response?.data["details"]?.toString() ?? dioError.message
          : dioError.message ?? "Unknown error";

      throw APIException(message: message!, statusCode: statusCode);
    } catch (e, stackTrace) {
      Log.warning(
        "Unexpected error while inviting member",
        e,
        stackTrace,
      );

      throw APIException(
        message: e.toString(),
        statusCode: -1,
      );
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
      Log.warning(
        "DioException while fetching chats",
        dioError,
        stackTrace,
      );

      final statusCode = dioError.response?.statusCode ?? -1;
      final message = dioError.response?.data is Map
          ? dioError.response?.data["details"]?.toString() ?? dioError.message
          : dioError.message ?? "Unknown error";

      throw APIException(message: message!, statusCode: statusCode);
    } catch (e, stackTrace) {
      Log.warning(
        "Unexpected error while fetching chats",
        e,
        stackTrace,
      );

      throw APIException(
        message: e.toString(),
        statusCode: -1,
      );
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
      Log.warning(
        "DioException while accepting invite",
        dioError,
        stackTrace,
      );

      final statusCode = dioError.response?.statusCode ?? -1;
      final message = dioError.response?.data is Map
          ? dioError.response?.data["detail"]?.toString() ?? dioError.message
          : dioError.message ?? "Unknown error";

      throw APIException(message: message!, statusCode: statusCode);
    } catch (e, stackTrace) {
      Log.warning(
        "Unexpected error while accepting invite",
        e,
        stackTrace,
      );

      throw APIException(
        message: e.toString(),
        statusCode: -1,
      );
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
      Log.warning(
        "DioException while deleting member",
        dioError,
        stackTrace,
      );

      final statusCode = dioError.response?.statusCode ?? -1;
      final message = dioError.response?.data is Map
          ? dioError.response?.data["detail"]?.toString() ?? dioError.message
          : dioError.message ?? "Unknown error";

      throw APIException(message: message!, statusCode: statusCode);
    } catch (e, stackTrace) {
      Log.warning(
        "Unexpected error while deleting member",
        e,
        stackTrace,
      );

      throw APIException(
        message: e.toString(),
        statusCode: -1,
      );
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
      Log.warning(
        "DioException while getting user",
        dioError,
        stackTrace,
      );

      final statusCode = dioError.response?.statusCode ?? -1;
      final message = dioError.response?.data is Map
          ? dioError.response?.data["detail"]?.toString() ?? dioError.message
          : dioError.message ?? "Unknown error";

      throw APIException(message: message!, statusCode: statusCode);
    } catch (e, stackTrace) {
      Log.warning(
        "Unexpected error while getting user",
        e,
        stackTrace,
      );

      throw APIException(
        message: e.toString(),
        statusCode: -1,
      );
    }
  }
}
