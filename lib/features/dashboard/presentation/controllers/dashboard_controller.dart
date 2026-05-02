import 'package:get/get.dart';
import 'package:manifesto/common/widgets/toast_message.dart';
import 'package:manifesto/features/dashboard/domain/entities/send_chat_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/usecases/new_chat_usecase.dart';
import 'package:manifesto/features/dashboard/domain/usecases/send_chat_usecase.dart';
import 'package:manifesto/features/dashboard/presentation/states/dashboard_state.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/common/chat_message.dart';
import 'package:toastification/toastification.dart';

class DashboardController extends GetxController {
  final DashboardState state;
  final NewChatUseCase newChatUseCase;
  final SendChatUseCase sendChatUseCase;

  DashboardController({
    required this.state,
    required this.newChatUseCase,
    required this.sendChatUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    startChat();

  }

  Future<void> startChat() async {
    final result = await newChatUseCase.call();
    result.fold((error) {
      showToastNotification(
        title: "Error",
        body: error.toString(),
        messageType: ToastificationType.error,
      );
    }, (data) {
      state.chatId = data.id;
    });
  }

  Future<void> sendChat() async {
    if (state.chatId == null) {
      showToastNotification(
        title: "Please Wait",
        body: "Chat is not ready yet, Please Wait!",
        messageType: ToastificationType.info,
      );
      return;
    }
    String message = state.chatController.text;
    if (message == "") {
      showToastNotification(
        title: "Oops",
        body: "I don't see any message",
        messageType: ToastificationType.info,
      );
      return;
    }
    state.chatMessages.add(
      ChatMessage(
        text: message,
        isUser: true,
      ),
    );
    state.chatting.value = true;
    state.chatController.clear();
    final result = await sendChatUseCase.call(
      SendChatUseCaseParams(
        request: SendChatRequestEntity(
          chatId: state.chatId!,
          message: message,
        ),
      ),
    );
    result.fold((error) {
      showToastNotification(
        title: "Error",
        body: error.toString(),
        messageType: ToastificationType.error,
      );
    }, (data) {
      state.chatMessages.add(
        ChatMessage(
          text: data.content,
          isUser: false,
        ),
      );
    });
    state.chatting.value = false;
  }
}
