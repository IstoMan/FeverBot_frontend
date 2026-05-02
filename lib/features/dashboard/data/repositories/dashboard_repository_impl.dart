import 'package:dartz/dartz.dart';
import 'package:manifesto/common/core/utils/errors/exceptions.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';
import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/features/dashboard/data/datasources/local/dashboard_local_datasource.dart';
import 'package:manifesto/features/dashboard/data/datasources/remote/dashboard_remote_datasource.dart';
import 'package:manifesto/features/dashboard/data/models/dashboard_model.dart';
import 'package:manifesto/features/dashboard/data/models/new_chat_model.dart';
import 'package:manifesto/features/dashboard/data/models/send_chat_model.dart';
import 'package:manifesto/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/new_chat_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/send_chat_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/send_chat_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final DashboardLocalDataSource localDataSource;

  DashboardRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  ResultFuture<DashboardEntity> getDashboardData() async {
    try {
      final DashboardModel model = await remoteDataSource.fetchDashboardData();

      return Right(model.toEntity());
    } on APIException catch (e) {
      Log.error("API Exception: ${e.message}");
      return Left(APIException(message: e.message, statusCode: e.statusCode));
    } on StorageException catch (e) {
      Log.error("Storage Exception: ${e.message}");
      return Left(StorageException(message: e.message));
    } catch (e, stackTrace) {
      Log.error("Unexpected error in DashboardRepositoryImpl", e, stackTrace);
      return Left(APIException(message: e.toString(), statusCode: -1));
    }
  }

  @override
  ResultFuture<NewChatEntity> startChat() async {
    try {
      final NewChatModel model = await remoteDataSource.startChat();

      return Right(model.toEntity());
    } on APIException catch (e) {
      Log.error("API Exception: ${e.message}");
      return Left(APIException(message: e.message, statusCode: e.statusCode));
    } on StorageException catch (e) {
      Log.error("Storage Exception: ${e.message}");
      return Left(StorageException(message: e.message));
    } catch (e, stackTrace) {
      Log.error("Unexpected error in DashboardRepositoryImpl", e, stackTrace);
      return Left(APIException(message: e.toString(), statusCode: -1));
    }
  }

  @override
  ResultFuture<SendChatEntity> sendChat(SendChatRequestEntity request) async {
    try {
      final SendChatModel model = await remoteDataSource.sendChat(request);
      return Right(model.toEntity());
    } on APIException catch (e) {
      Log.error("API Exception: ${e.message}");
      return Left(APIException(message: e.message, statusCode: e.statusCode));
    } on StorageException catch (e) {
      Log.error("Storage Exception: ${e.message}");
      return Left(StorageException(message: e.message));
    } catch (e, stackTrace) {
      Log.error("Unexpected error in DashboardRepositoryImpl", e, stackTrace);
      return Left(APIException(message: e.toString(), statusCode: -1));
    }
  }
}
