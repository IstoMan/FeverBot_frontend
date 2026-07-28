import 'package:flutter/material.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';
import 'package:manifesto/common/widgets/shadow_container.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/common/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage chatMessage;
  final bool isStreaming;

  const ChatBubble({
    super.key,
    required this.chatMessage,
    this.isStreaming = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
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
              child: _BubbleBody(
                chatMessage: chatMessage,
                isStreaming: isStreaming,
              ),
            ),
          ),
          AppGaps.h8,
          Align(
            alignment:
                chatMessage.isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              chatMessage.isUser ? "YOU" : "FEVERBOT",
              style: AppTextStyles.geistSmallRegular.copyWith(
                color: AppColors.black,
              ),
            ),
          )
        ],
      ),
    );

    if (!chatMessage.animateEntrance) {
      return content;
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 12),
            child: child,
          ),
        );
      },
      child: content,
    );
  }
}

class _BubbleBody extends StatelessWidget {
  final ChatMessage chatMessage;
  final bool isStreaming;

  const _BubbleBody({
    required this.chatMessage,
    required this.isStreaming,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.geistNormalSemiBold.copyWith(
      color: chatMessage.isUser ? AppColors.white : AppColors.black,
    );

    if (!chatMessage.isUser && chatMessage.text.isEmpty && isStreaming) {
      return Text('…', style: style);
    }

    if (!chatMessage.isUser && isStreaming) {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(text: chatMessage.text, style: style),
            TextSpan(
              text: '|',
              style: style.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      );
    }

    return Text(chatMessage.text, style: style);
  }
}
