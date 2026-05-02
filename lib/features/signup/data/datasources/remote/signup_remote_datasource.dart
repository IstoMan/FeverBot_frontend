import 'package:dio/dio.dart';
import 'package:manifesto/common/core/utils/errors/exceptions.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';
import 'package:manifesto/common/resources/network_resources/api_endpoints.dart';
import 'package:manifesto/common/resources/network_resources/rest_client/rest_client.dart';
import 'package:manifesto/features/signup/data/models/signup_request_model.dart';
import 'package:manifesto/features/signup/domain/entities/signup_entity.dart';
import 'package:manifesto/features/signup/domain/entities/signup_request_entity.dart';

import '../../models/signup_model.dart';

abstract class SignupRemoteDataSource {
  Future<SignupEntity> fetchSignupData(SignupRequestEntity request);
}

class SignupRemoteDataSourceImpl extends SignupRemoteDataSource {
  final RestClient _restClient;

  SignupRemoteDataSourceImpl(this._restClient);

  @override
  Future<SignupEntity> fetchSignupData(SignupRequestEntity request) async {
    try {
      final requestModel = SignupRequestModel.fromEntity(request);
      final response = await _restClient.post(
        APIEndpoints.signupEndPoint,
        data: requestModel.toJson(),
      );
      return SignupModel.fromJson(response);
    } on DioException catch (dioError, stackTrace) {
      Log.warning(
        "DioException while fetching signup data",
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
        "Unexpected error while fetching signup data",
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
