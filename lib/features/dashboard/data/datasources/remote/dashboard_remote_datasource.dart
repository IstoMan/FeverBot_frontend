import 'package:dio/dio.dart';
import 'package:manifesto/common/resources/network_resources/rest_client/rest_client.dart';
import 'package:manifesto/common/core/utils/errors/exceptions.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';
import 'package:manifesto/common/resources/network_resources/api_endpoints.dart';
import 'package:manifesto/features/dashboard/data/models/dashboard_model.dart';
import 'package:manifesto/features/dashboard/domain/entities/dashboard_request_entity.dart';
import 'package:manifesto/features/dashboard/data/models/dashboard_request_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardModel> fetchDashboardData(DashboardRequestEntity request);
}

class DashboardRemoteDataSourceImpl extends DashboardRemoteDataSource {
  final RestClient _restClient;

  DashboardRemoteDataSourceImpl(this._restClient);

  @override
  Future<DashboardModel> fetchDashboardData(
      DashboardRequestEntity request) async {
    try {
      final requestModel = DashboardRequestModel.fromEntity(request);
      final response = await _restClient
          .get(APIEndpoints.dashboardDataEndPointById(requestModel.id));
      return DashboardModel.fromJson(response);
    } on DioException catch (dioError, stackTrace) {
      Log.warning(
        "DioException while fetching dashboard data",
        dioError,
        stackTrace,
      );

      final statusCode = dioError.response?.statusCode ?? -1;
      final message = dioError.response?.data is Map
          ? dioError.response?.data["message"]?.toString() ?? dioError.message
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
}
