import 'package:flutter/material.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';
import 'package:manifesto/common/widgets/shadow_container.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/dashboard/dial_painter.dart';

class DialContainer extends StatefulWidget {
  final double riskScore;
  final String riskClass;

  const DialContainer({
    super.key,
    required this.riskScore,
    required this.riskClass,
  });

  @override
  State<DialContainer> createState() => _DialContainerState();
}

class _DialContainerState extends State<DialContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _animation = Tween<double>(begin: 0, end: widget.riskScore / 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant DialContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.riskScore != widget.riskScore) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.riskScore / 100,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RShadowContainer(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.w20,
          vertical: AppSizes.h20,
        ),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "BIOMETRIC RISK ASSESSMENT",
                style: AppTextStyles.geistNormalBold.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
            AppGaps.h20,
            SizedBox(
              width: AppSizes.w200,
              height: AppSizes.h200,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final animatedScore = _animation.value * 100;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: Size(
                          AppSizes.w200,
                          AppSizes.h200,
                        ),
                        painter: DialPainter(
                          progress: _animation.value,
                          trackColor: const Color(0xFFE8E8E8),
                          progressColor: AppColors.primary,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            animatedScore.toStringAsFixed(1),
                            style:
                                AppTextStyles.geistLargeMediumLight.copyWith(
                              color: AppColors.black,
                              fontSize: AppSizes.f60,
                            ),
                          ),
                          Text(
                            "${widget.riskClass.toUpperCase()} RISK",
                            style: AppTextStyles.geistSmallSemiBold.copyWith(
                              color: AppColors.primary,
                              letterSpacing: 1.4,
                            ),
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
