import 'package:flutter/material.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';
import 'package:manifesto/common/widgets/shadow_container.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/common/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage chatMessage;

  const ChatBubble({
    super.key,
    required this.chatMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: chatMessage.isUser ? AppSizes.w50 : 0,
        right: chatMessage.isUser ? 0 : AppSizes.w50,
        top: AppSizes.h30,
      ),
      child: Column(
        children: [
          RShadowContainer(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.w20,
                vertical: AppSizes.h10,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: chatMessage.isUser ? AppColors.primary : AppColors.white,
              ),
              child: Expanded(
                child: Text(
                  chatMessage.text,
                  style: AppTextStyles.geistNormalSemiBold.copyWith(
                    color:
                        chatMessage.isUser ? AppColors.white : AppColors.black,
                  ),
                ),
              ),
            ),
          ),
          AppGaps.h8,
          Align(
            alignment: chatMessage.isUser
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              chatMessage.isUser ? "YOU" : "AI ASSISTANT",
              style: AppTextStyles.geistSmallRegular.copyWith(
                color: AppColors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
