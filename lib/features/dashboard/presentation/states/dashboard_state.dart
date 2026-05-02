import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifesto/features/dashboard/domain/entities/dashboard_entity.dart';

import '../widgets/common/chat_message.dart';

class DashboardState extends GetXState {
  RxBool isLoading = false.obs;
  final dashboardData = Rxn<DashboardEntity>();
  RxBool chatting = false.obs;
  RxInt currentIndex = 0.obs;
  final TextEditingController chatController = TextEditingController();
  RxList<ChatMessage> chatMessages = <ChatMessage>[
    ChatMessage(
      text: "Hello",
      isUser: true,
    ),
    ChatMessage(
      text:
          "Hi I am Feeling greatjkenf vkernornf fvkrnviefn kbfierf fefiebfenf bfihbfvierfer jer vj vv vibfbifk gibbiv  ",
      isUser: false,
    ),
  ].obs;
  Rxn<DashboardEntity> riskScore = Rxn<DashboardEntity>();
  String? chatId;
}
