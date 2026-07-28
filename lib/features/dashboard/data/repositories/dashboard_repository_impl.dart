import 'package:dartz/dartz.dart';
import 'package:manifesto/common/core/utils/errors/exceptions.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';
import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/features/dashboard/data/datasources/local/dashboard_local_datasource.dart';
import 'package:manifesto/features/dashboard/data/datasources/remote/dashboard_remote_datasource.dart';
import 'package:manifesto/features/dashboard/data/models/chat_history_model.dart';
import 'package:manifesto/features/dashboard/data/models/dashboard_model.dart';
import 'package:manifesto/features/dashboard/data/models/delete_member_model.dart';
import 'package:manifesto/features/dashboard/data/models/family_model.dart';
import 'package:manifesto/features/dashboard/data/models/invite_model.dart';
import 'package:manifesto/features/dashboard/data/models/new_chat_model.dart';
import 'package:manifesto/features/dashboard/data/models/user_model.dart';
import 'package:manifesto/features/dashboard/domain/entities/accept_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/chat_history_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/chat_stream_event.dart';
import 'package:manifesto/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/delete_member_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/delete_member_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/family_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/invite_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/invite_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/new_chat_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/send_chat_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/user_entity.dart';
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
  Stream<ChatStreamEvent> streamChat(SendChatRequestEntity request) {
    return remoteDataSource.streamChat(request);
  }

  @override
  ResultFuture<FamilyEntity> getFamily() async {
    try {
      final FamilyModel model = await remoteDataSource.getFamily();
      await localDataSource.cacheFamily(model);
      return Right(model.toEntity());
    } on APIException catch (e) {
      Log.error("API Exception: ${e.message}");
      final cached = await localDataSource.getCachedFamily();
      if (cached != null) return Right(cached.toEntity());
      return Left(APIException(message: e.message, statusCode: e.statusCode));
    } on StorageException catch (e) {
      Log.error("Storage Exception: ${e.message}");
      return Left(StorageException(message: e.message));
    } catch (e, stackTrace) {
      Log.error("Unexpected error in DashboardRepositoryImpl", e, stackTrace);
      final cached = await localDataSource.getCachedFamily();
      if (cached != null) return Right(cached.toEntity());
      return Left(APIException(message: e.toString(), statusCode: -1));
    }
  }

  @override
  ResultFuture<InviteEntity> inviteMember(InviteRequestEntity request) async {
    try {
      final InviteModel model = await remoteDataSource.inviteMember(request);
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
  ResultFuture<List<ChatHistoryEntity>> getChats() async {
    try {
      final List<ChatHistoryModel> model = await remoteDataSource.getChats();
      return Right(model);
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
  ResultFuture<FamilyEntity> acceptInvite(AcceptRequestEntity request) async {
    try {
      final FamilyModel model = await remoteDataSource.acceptInvite(request);
      await localDataSource.cacheFamily(model);
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
  ResultFuture<DeleteMemberEntity> removeMember(
      DeleteMemberRequestEntity request) async {
    try {
      final DeleteMemberModel model =
          await remoteDataSource.deleteMember(request);
      return Right(model);
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
  ResultFuture<UserEntity> getUser() async {
    try {
      final UserModel model = await remoteDataSource.getUser();
      await localDataSource.cacheUser(model);
      return Right(model.toEntity());
    } on APIException catch (e) {
      Log.error("API Exception: ${e.message}");
      final cached = await localDataSource.getCachedUser();
      if (cached != null) return Right(cached.toEntity());
      return Left(APIException(message: e.message, statusCode: e.statusCode));
    } on StorageException catch (e) {
      Log.error("Storage Exception: ${e.message}");
      return Left(StorageException(message: e.message));
    } catch (e, stackTrace) {
      Log.error("Unexpected error in DashboardRepositoryImpl", e, stackTrace);
      final cached = await localDataSource.getCachedUser();
      if (cached != null) return Right(cached.toEntity());
      return Left(APIException(message: e.toString(), statusCode: -1));
    }
  }
}
