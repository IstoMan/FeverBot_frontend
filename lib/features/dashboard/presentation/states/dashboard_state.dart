import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifesto/features/dashboard/domain/entities/chat_history_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/family_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/user_entity.dart';

import '../widgets/common/chat_message.dart';

class DashboardState extends GetXState {
  RxBool isLoading = false.obs;
  final dashboardData = Rxn<DashboardEntity>();
  RxBool chatting = false.obs;
  RxBool invitingMember = false.obs;
  RxBool sharingQr = false.obs;
  RxInt currentIndex = 0.obs;
  final TextEditingController chatController = TextEditingController();
  RxList<ChatMessage> chatMessages = <ChatMessage>[].obs;
  Rxn<DashboardEntity> riskScore = Rxn<DashboardEntity>();
  String? chatId;
  Rxn<FamilyEntity> family = Rxn<FamilyEntity>();
  RxList<ChatHistoryEntity> chatHistory = <ChatHistoryEntity>[].obs;
  Rxn<UserEntity> user = Rxn<UserEntity>();
}
