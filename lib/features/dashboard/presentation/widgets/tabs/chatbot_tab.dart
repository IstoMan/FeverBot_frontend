import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/widgets/shadow_container.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/common/chat_bubble.dart';

import '../../../../../common/widgets/text_field.dart';
import '../../controllers/dashboard_controller.dart';

class ChatbotTab extends GetView<DashboardController> {
  const ChatbotTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(
        left: AppSizes.w15,
        right: AppSizes.w15,
        bottom: bottomInset > 0 ? AppSizes.h8 : 0,
      ),
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                reverse: true,
                itemCount: controller.state.chatMessages.length,
                itemBuilder: (context, index) {
                  final message = controller.state.chatMessages[
                      controller.state.chatMessages.length - 1 - index];
                  return ChatBubble(
                    key: ValueKey('${message.isUser}_${message.text}_$index'),
                    chatMessage: message,
                  );
                },
              ),
            ),
          ),
          AppGaps.h10,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: RTextField(
                  controller: controller.state.chatController,
                  hint: 'Type your response',
                ),
              ),
              AppGaps.w10,
              RShadowContainer(
                child: Container(
                  width: AppSizes.w40,
                  height: AppSizes.h40,
                  decoration: const BoxDecoration(color: AppColors.primary),
                  child: Obx(
                    () => controller.state.chatting.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.w10,
                            ),
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: AppColors.white,
                              size: AppSizes.v25,
                            ),
                          )
                        : IconButton(
                            onPressed: controller.sendChat,
                            icon: const Icon(
                              Icons.send,
                              color: AppColors.white,
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
          AppGaps.h20,
        ],
      ),
    );
  }
}
