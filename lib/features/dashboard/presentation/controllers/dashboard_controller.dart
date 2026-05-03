import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:manifesto/common/widgets/toast_message.dart';
import 'package:manifesto/features/dashboard/domain/entities/accept_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/delete_member_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/invite_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/send_chat_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/usecases/accept_invite_usecase.dart';
import 'package:manifesto/features/dashboard/domain/usecases/delete_member_usecase.dart';
import 'package:manifesto/features/dashboard/domain/usecases/get_chats_usecase.dart';
import 'package:manifesto/features/dashboard/domain/usecases/get_family_usecase.dart';
import 'package:manifesto/features/dashboard/domain/usecases/get_user_usecase.dart';
import 'package:manifesto/features/dashboard/domain/usecases/invite_member_usecase.dart';
import 'package:manifesto/features/dashboard/domain/usecases/new_chat_usecase.dart';
import 'package:manifesto/features/dashboard/domain/usecases/send_chat_usecase.dart';
import 'package:manifesto/features/dashboard/presentation/states/dashboard_state.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/common/chat_message.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/common/qr_code_dialog.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toastification/toastification.dart';

class DashboardController extends GetxController {
  final DashboardState state;
  final NewChatUseCase newChatUseCase;
  final SendChatUseCase sendChatUseCase;
  final GetFamilyUseCase getFamilyUseCase;
  final InviteMemberUseCase inviteMemberUseCase;
  final GetChatsUseCase getChatsUseCase;
  final AcceptInviteUseCase acceptInviteUseCase;
  final DeleteMemberUseCase deleteMemberUseCase;
  final GetUserUseCase getUserUseCase;

  DashboardController({
    required this.state,
    required this.newChatUseCase,
    required this.sendChatUseCase,
    required this.getFamilyUseCase,
    required this.inviteMemberUseCase,
    required this.getChatsUseCase,
    required this.acceptInviteUseCase,
    required this.deleteMemberUseCase,
    required this.getUserUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    startChat();
    getFamily();
    getUser();
  }

  Future<void> getChatHistory() async {
    final result = await getChatsUseCase.call();
    result.fold((error) {
      showToastNotification(
        title: "Error",
        body: error.toString(),
        messageType: ToastificationType.error,
      );
    }, (data) {
      state.chatHistory.value = data;
    });
  }

  Future<void> createInvitation(String relation) async {
    if (relation == "") {
      showToastNotification(
        title: "Oops!",
        body: "Please make sure you entered relation",
        messageType: ToastificationType.info,
      );
      return;
    }
    Get.back();
    state.invitingMember.value = true;
    final result = await inviteMemberUseCase.call(
      InviteMemberUseCaseParams(
        request: InviteRequestEntity(targetRole: relation),
      ),
    );
    result.fold((error) {
      showToastNotification(
        title: "Error",
        body: error.toString(),
        messageType: ToastificationType.error,
      );
    }, (data) {
      QrCodeDialog.show(
        imageBase64: data.QRBase64,
        onShare: () =>
            shareQrCode(data.QRBase64, data.QRMediaType, data.inviteUrl),
      );
    });
    state.invitingMember.value = false;
  }

  void shareQrCode(String imageBase64, String mediaType, String link) async {
    final bytes = base64Decode(imageBase64.split(',').last);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/image.png');
    await file.writeAsBytes(bytes);
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile(
            file.path,
            mimeType: mediaType,
          ),
        ],
        text: "Scan this QR code to join my family on FamBot!",
      ),
    );
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

  Future<void> getFamily() async {
    final result = await getFamilyUseCase.call();
    result.fold((error) {
      showToastNotification(
        title: "Error",
        body: error.toString(),
        messageType: ToastificationType.error,
      );
    }, (data) {
      state.family.value = data;
    });
  }

  Future<void> scanQR(BarcodeCapture capture) async {
    final String? link = capture.barcodes.first.rawValue;
    if (link == null) {
      showToastNotification(
        title: "Oops",
        body: "No link found, please scan again",
        messageType: ToastificationType.info,
      );
      return;
    }
    String token = link.substring(50);
    final result = await acceptInviteUseCase.call(
      AcceptInviteUseCaseParams(
        request: AcceptRequestEntity(
          token: token,
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
      state.family.value = data;
    });
  }

  Future<void> deleteMember(String memberId) async {
    final result = await deleteMemberUseCase.call(
      DeleteMemberUseCaseParams(
        request: DeleteMemberRequestEntity(memberId: memberId),
      ),
    );
    result.fold((error) {
      showToastNotification(
        title: "Error",
        body: error.toString(),
        messageType: ToastificationType.error,
      );
    }, (data) {
      state.family.value?.members
          .removeWhere((member) => member.uuid == data.removedId);
    });
  }

  Future<void> getUser() async {
    final result = await getUserUseCase.call();
    result.fold((error) {
      showToastNotification(
        title: "Error",
        body: error.toString(),
        messageType: ToastificationType.error,
      );
    }, (data) {
      state.user.value = data;
      showToastNotification(
          title: "Something", body: (state.user.value == null).toString());
    });
  }
}
