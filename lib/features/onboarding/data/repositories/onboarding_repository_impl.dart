import 'package:dartz/dartz.dart';
import 'package:manifesto/features/onboarding/data/datasources/remote/onboarding_remote_datasource.dart';
import 'package:manifesto/features/onboarding/data/datasources/local/onboarding_local_datasource.dart';
import 'package:manifesto/features/onboarding/data/models/onboarding_model.dart';
import 'package:manifesto/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:manifesto/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';
import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/errors/exceptions.dart';
import 'package:manifesto/features/onboarding/domain/entities/onboarding_request_entity.dart';

class OnboardingRepositoryImpl extends OnboardingRepository {
  final OnboardingRemoteDataSource remoteDataSource;
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  ResultFuture<OnboardingEntity> getOnboardingData(
      {required OnboardingRequestEntity request}) async {
    try {
      final OnboardingModel model =
          await remoteDataSource.fetchOnboardingData(request);

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
      Log.error("Unexpected error in OnboardingRepositoryImpl", e, stackTrace);
      return Left(APIException(message: e.toString(), statusCode: -1));
    }
  }
}
