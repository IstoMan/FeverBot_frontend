import 'package:flutter/material.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';
import 'package:manifesto/common/widgets/shadow_container.dart';

class MetricsContainer extends StatelessWidget {
  final int age;
  final String gender;
  final double height;
  final double weight;

  const MetricsContainer({
    super.key,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PHYSICAL METRICS",
              style: AppTextStyles.geistNormalBold.copyWith(
                color: AppColors.black,
              ),
            ),
            AppGaps.h20,
            Row(
              children: [
                Expanded(
                  child: _MetricCell(label: "AGE", value: age.toString()),
                ),
                Container(
                  width: 1,
                  height: AppSizes.h48,
                  color: AppColors.black.withOpacity(0.12),
                ),
                Expanded(
                  child: _MetricCell(
                    label: "GENDER",
                    value: gender.toUpperCase(),
                  ),
                ),
              ],
            ),
            Divider(
              height: AppSizes.h30,
              thickness: 1,
              color: AppColors.black.withOpacity(0.12),
            ),
            Row(
              children: [
                Expanded(
                  child: _MetricCell(
                    label: "HEIGHT",
                    value: height.toStringAsFixed(1),
                  ),
                ),
                Container(
                  width: 1,
                  height: AppSizes.h48,
                  color: AppColors.black.withOpacity(0.12),
                ),
                Expanded(
                  child: _MetricCell(
                    label: "WEIGHT",
                    value: weight.toStringAsFixed(1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCell extends StatelessWidget {
  final String label;
  final String value;

  const _MetricCell({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.w10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.geistSmallRegular.copyWith(
              color: AppColors.black3,
              letterSpacing: 1.2,
            ),
          ),
          AppGaps.h4,
          Text(
            value,
            style: AppTextStyles.geistExtraExtraLargeExtraBold.copyWith(
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
