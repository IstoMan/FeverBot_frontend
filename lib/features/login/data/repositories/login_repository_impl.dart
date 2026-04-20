import 'package:dartz/dartz.dart';
import 'package:manifesto/features/login/data/datasources/remote/login_remote_datasource.dart';
import 'package:manifesto/features/login/data/datasources/local/login_local_datasource.dart';
import 'package:manifesto/features/login/data/models/login_model.dart';
import 'package:manifesto/features/login/domain/entities/login_entity.dart';
import 'package:manifesto/features/login/domain/repositories/login_repository.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';
import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/errors/exceptions.dart';
import 'package:manifesto/features/login/domain/entities/login_request_entity.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;

  LoginRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  ResultFuture<LoginEntity> getLoginData(
      {required LoginRequestEntity request}) async {
    try {
      final LoginModel model = await remoteDataSource.fetchLoginData(request);

      // Optionally cache something locally if needed
      localDataSource.setAccessToken(model.id);

      return Right(model.toEntity()); // convert to domain entity
    } on APIException catch (e) {
      Log.error("API Exception: ${e.message}");
      return Left(APIException(message: e.message, statusCode: e.statusCode));
    } on StorageException catch (e) {
      Log.error("Storage Exception: ${e.message}");
      return Left(StorageException(message: e.message));
    } catch (e, stackTrace) {
      Log.error("Unexpected error in LoginRepositoryImpl", e, stackTrace);
      return Left(APIException(message: e.toString(), statusCode: -1));
    }
  }
}
