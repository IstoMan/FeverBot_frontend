import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:manifesto/common/widgets/toast_message.dart';
import 'package:manifesto/features/dashboard/domain/entities/accept_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/chat_stream_event.dart';
import 'package:manifesto/features/dashboard/domain/entities/delete_member_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/family_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/invite_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/send_chat_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/usecases/accept_invite_usecase.dart';
import 'package:manifesto/features/dashboard/domain/usecases/delete_member_usecase.dart';
import 'package:manifesto/features/dashboard/domain/usecases/get_family_usecase.dart';
import 'package:manifesto/features/dashboard/domain/usecases/get_user_usecase.dart';
import 'package:manifesto/features/dashboard/domain/usecases/invite_member_usecase.dart';
import 'package:manifesto/features/dashboard/domain/usecases/new_chat_usecase.dart';
import 'package:manifesto/features/dashboard/domain/usecases/stream_chat_usecase.dart';
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
  final StreamChatUseCase streamChatUseCase;
  final GetFamilyUseCase getFamilyUseCase;
  final InviteMemberUseCase inviteMemberUseCase;
  final AcceptInviteUseCase acceptInviteUseCase;
  final DeleteMemberUseCase deleteMemberUseCase;
  final GetUserUseCase getUserUseCase;

  bool _chatLoaded = false;
  bool _familyLoaded = false;
  bool _userLoaded = false;
  Uint8List? _lastQrBytes;
  String? _lastQrMediaType;
  StreamSubscription<ChatStreamEvent>? _chatStreamSub;

  DashboardController({
    required this.state,
    required this.newChatUseCase,
    required this.streamChatUseCase,
    required this.getFamilyUseCase,
    required this.inviteMemberUseCase,
    required this.acceptInviteUseCase,
    required this.deleteMemberUseCase,
    required this.getUserUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  @override
  void onClose() {
    _chatStreamSub?.cancel();
    state.chatController.dispose();
    super.onClose();
  }

  void changeTab(int index) {
    state.currentIndex.value = index;
    switch (index) {
      case 0:
        if (!_userLoaded) getUser();
        break;
      case 1:
        if (!_chatLoaded) startChat();
        break;
      case 2:
        if (!_familyLoaded) getFamily();
        break;
    }
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
      _lastQrBytes = QrCodeDialog.decodeQrBytes(data.QRBase64);
      _lastQrMediaType = data.QRMediaType;
      QrCodeDialog.show(
        imageBase64: data.QRBase64,
        decodedBytes: _lastQrBytes,
        onShare: () => shareQrCode(
          data.inviteUrl,
          bytes: _lastQrBytes,
          mediaType: _lastQrMediaType,
        ),
      );
    });
    state.invitingMember.value = false;
  }

  Future<void> shareQrCode(
    String link, {
    Uint8List? bytes,
    String? mediaType,
  }) async {
    final qrBytes = bytes ?? _lastQrBytes;
    if (qrBytes == null) return;
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/feverbot_invite.png');
    await file.writeAsBytes(qrBytes);
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile(
            file.path,
            mimeType: mediaType ?? _lastQrMediaType ?? 'image/png',
          ),
        ],
        text: "Scan this QR code to join my family on FeverBot!\n$link",
      ),
    );
  }

  Future<void> startChat() async {
    _chatLoaded = true;
    final result = await newChatUseCase.call();
    result.fold((error) {
      _chatLoaded = false;
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
    if (state.chatting.value) return;

    if (state.chatId == null) {
      showToastNotification(
        title: "Please Wait",
        body: "Chat is not ready yet, Please Wait!",
        messageType: ToastificationType.info,
      );
      return;
    }
    final message = state.chatController.text;
    if (message == "") {
      showToastNotification(
        title: "Oops",
        body: "I don't see any message",
        messageType: ToastificationType.info,
      );
      return;
    }

    await _chatStreamSub?.cancel();

    state.chatMessages.add(
      ChatMessage(
        text: message,
        isUser: true,
      ),
    );

    final botMessage = ChatMessage(
      text: '',
      isUser: false,
      animateEntrance: true,
    );
    state.chatMessages.add(botMessage);
    final botIndex = state.chatMessages.length - 1;

    state.chatting.value = true;
    state.chatController.clear();

    _chatStreamSub = streamChatUseCase
        .call(
          StreamChatUseCaseParams(
            request: SendChatRequestEntity(
              chatId: state.chatId!,
              message: message,
            ),
          ),
        )
        .listen(
      (event) {
        switch (event) {
          case ChatStreamToken(:final text):
            if (text.isEmpty) return;
            final current = state.chatMessages[botIndex];
            current.text = '${current.text}$text';
            current.animateEntrance = false;
            state.chatMessages.refresh();
          case ChatStreamError(:final message):
            showToastNotification(
              title: "Error",
              body: message,
              messageType: ToastificationType.error,
            );
            if (state.chatMessages[botIndex].text.isEmpty) {
              state.chatMessages[botIndex].text =
                  "Sorry, I couldn't complete that reply.";
              state.chatMessages.refresh();
            }
            state.chatting.value = false;
          case ChatStreamMessageEnd():
            state.chatting.value = false;
          case ChatStreamMessageStart():
          case ChatStreamIgnored():
            break;
        }
      },
      onError: (Object error) {
        showToastNotification(
          title: "Error",
          body: error.toString(),
          messageType: ToastificationType.error,
        );
        if (botIndex < state.chatMessages.length &&
            state.chatMessages[botIndex].text.isEmpty) {
          state.chatMessages[botIndex].text =
              "Sorry, I couldn't complete that reply.";
          state.chatMessages.refresh();
        }
        state.chatting.value = false;
      },
      onDone: () {
        state.chatting.value = false;
      },
      cancelOnError: true,
    );
  }

  Future<void> getFamily() async {
    _familyLoaded = true;
    final result = await getFamilyUseCase.call();
    result.fold((error) {
      _familyLoaded = false;
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
      _familyLoaded = true;
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
      final current = state.family.value;
      if (current == null) return;
      state.family.value = FamilyEntity(
        groupId: current.groupId,
        ownerId: current.ownerId,
        members: current.members
            .where((member) => member.uuid != data.removedId)
            .toList(),
      );
    });
  }

  Future<void> getUser() async {
    _userLoaded = true;
    final result = await getUserUseCase.call();
    result.fold((error) {
      _userLoaded = false;
      showToastNotification(
        title: "Error",
        body: error.toString(),
        messageType: ToastificationType.error,
      );
    }, (data) {
      state.user.value = data;
    });
  }
}
