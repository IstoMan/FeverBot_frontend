import 'package:flutter/material.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';
import 'package:manifesto/common/widgets/shadow_container.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/dashboard/dial_painter.dart';

class DialContainer extends StatelessWidget {
  final double riskScore;
  final String riskClass;

  const DialContainer({
    super.key,
    required this.riskScore,
    required this.riskClass,
  });

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
            const Align(
              alignment: Alignment.topLeft,
              child: Text("BIOMETRIC RISK ASSESSMENT"),
            ),
            AppGaps.h20,
            SizedBox(
              width: AppSizes.w200,
              height: AppSizes.h200,
              child: Stack(alignment: Alignment.center, children: [
                CustomPaint(
                  size: Size(
                    AppSizes.w200,
                    AppSizes.h200,
                  ),
                  painter: DialPainter(
                    progress: riskScore / 100,
                    trackColor: const Color(0xFFE8E8E8),
                    progressColor: const Color(0xFFF04E23),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      riskScore.toString(),
                      style: AppTextStyles.geistLargeMediumLight.copyWith(
                          color: AppColors.black, fontSize: AppSizes.f60),
                    ),
                    Text(
                      "${riskClass.toUpperCase()} RISK",
                      style: AppTextStyles.geistSmallSemiBold.copyWith(
                          color: const Color(0xFFF04E23), letterSpacing: 1.4),
                    )
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
