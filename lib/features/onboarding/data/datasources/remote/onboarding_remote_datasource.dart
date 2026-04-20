import 'package:dio/dio.dart';
import 'package:manifesto/common/resources/network_resources/rest_client/rest_client.dart';
import 'package:manifesto/common/core/utils/errors/exceptions.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';
import 'package:manifesto/common/resources/network_resources/api_endpoints.dart';
import 'package:manifesto/features/onboarding/data/models/onboarding_model.dart';
import 'package:manifesto/features/onboarding/domain/entities/onboarding_request_entity.dart';
import 'package:manifesto/features/onboarding/data/models/onboarding_request_model.dart';

abstract class OnboardingRemoteDataSource {
  Future<OnboardingModel> fetchOnboardingData(OnboardingRequestEntity request);
}

class OnboardingRemoteDataSourceImpl extends OnboardingRemoteDataSource {
  final RestClient _restClient;

  OnboardingRemoteDataSourceImpl(this._restClient);

  @override
  Future<OnboardingModel> fetchOnboardingData(
      OnboardingRequestEntity request) async {
    try {
      final requestModel = OnboardingRequestModel.fromEntity(request);
      final response = await _restClient
          .get(APIEndpoints.onboardingDataEndPointById(requestModel.id));
      return OnboardingModel.fromJson(response);
    } on DioException catch (dioError, stackTrace) {
      Log.warning(
        "DioException while fetching onboarding data",
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
        "Unexpected error while fetching onboarding data",
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
