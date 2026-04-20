import 'package:get/get.dart';
import 'package:manifesto/features/dashboard/domain/entities/dashboard_entity.dart';

import '../widgets/common/chat_message.dart';

class DashboardState extends GetXState {
  RxBool isLoading = false.obs;
  final dashboardData = Rxn<DashboardEntity>();
  RxInt currentIndex = 0.obs;
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
}
