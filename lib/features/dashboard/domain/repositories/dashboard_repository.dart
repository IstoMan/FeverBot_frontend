import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/new_chat_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/send_chat_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/send_chat_request_entity.dart';

abstract class DashboardRepository {
  ResultFuture<DashboardEntity> getDashboardData();

  ResultFuture<NewChatEntity> startChat();

  ResultFuture<SendChatEntity> sendChat(SendChatRequestEntity request);
}
