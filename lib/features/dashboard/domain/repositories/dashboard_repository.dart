import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/features/dashboard/domain/entities/accept_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/chat_history_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/delete_member_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/delete_member_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/family_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/invite_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/new_chat_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/send_chat_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/send_chat_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/user_entity.dart';

import '../entities/invite_request_entity.dart';

abstract class DashboardRepository {
  ResultFuture<DashboardEntity> getDashboardData();

  ResultFuture<NewChatEntity> startChat();

  ResultFuture<SendChatEntity> sendChat(SendChatRequestEntity request);

  ResultFuture<FamilyEntity> getFamily();

  ResultFuture<InviteEntity> inviteMember(InviteRequestEntity request);

  ResultFuture<List<ChatHistoryEntity>> getChats();

  ResultFuture<FamilyEntity> acceptInvite(AcceptRequestEntity request);

  ResultFuture<DeleteMemberEntity> removeMember(
      DeleteMemberRequestEntity request);

  ResultFuture<UserEntity> getUser();
}
