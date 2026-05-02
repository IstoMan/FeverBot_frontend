import 'package:dio/dio.dart';
import 'package:manifesto/common/core/utils/errors/exceptions.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';
import 'package:manifesto/common/resources/network_resources/api_endpoints.dart';
import 'package:manifesto/common/resources/network_resources/rest_client/rest_client.dart';
import 'package:manifesto/features/dashboard/data/models/dashboard_model.dart';
import 'package:manifesto/features/dashboard/data/models/new_chat_model.dart';
import 'package:manifesto/features/dashboard/data/models/send_chat_model.dart';
import 'package:manifesto/features/dashboard/data/models/send_chat_request_model.dart';

import '../../../domain/entities/send_chat_request_entity.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardModel> fetchDashboardData();

  Future<NewChatModel> startChat();

  Future<SendChatModel> sendChat(SendChatRequestEntity request);
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
}
