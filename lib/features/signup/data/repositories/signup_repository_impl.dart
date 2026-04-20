import 'package:dartz/dartz.dart';
import 'package:manifesto/features/signup/data/datasources/remote/signup_remote_datasource.dart';
import 'package:manifesto/features/signup/data/datasources/local/signup_local_datasource.dart';
import 'package:manifesto/features/signup/domain/repositories/signup_repository.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';
import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/errors/exceptions.dart';
import 'package:manifesto/features/signup/domain/entities/signup_request_entity.dart';

class SignupRepositoryImpl extends SignupRepository {
  final SignupRemoteDataSource remoteDataSource;
  final SignupLocalDataSource localDataSource;

  SignupRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  ResultVoid getSignupData(
      {required SignupRequestEntity request}) async {
    try {
      await remoteDataSource.fetchSignupData(request);
      localDataSource.setAccessToken(model.id);

      return; // convert to domain entity
    } on APIException catch (e) {
      Log.error("API Exception: ${e.message}");
      return Left(APIException(message: e.message, statusCode: e.statusCode));
    } on StorageException catch (e) {
      Log.error("Storage Exception: ${e.message}");
      return Left(StorageException(message: e.message));
    } catch (e, stackTrace) {
      Log.error("Unexpected error in SignupRepositoryImpl", e, stackTrace);
      return Left(APIException(message: e.toString(), statusCode: -1));
    }
  }
}
