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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: RShadowContainer(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.w10,
                        vertical: AppSizes.h10,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("AGE"),
                          Text(
                            age.toString(),
                            style: AppTextStyles.geistExtraExtraLargeExtraBold
                                .copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AppGaps.w20,
                Expanded(
                  child: RShadowContainer(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.w10,
                        vertical: AppSizes.h10,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("GENDER"),
                          Text(
                            gender.toUpperCase(),
                            style: AppTextStyles.geistExtraExtraLargeExtraBold
                                .copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AppGaps.h20,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: RShadowContainer(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.w10,
                        vertical: AppSizes.h10,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("HEIGHT"),
                          Text(
                            height.toStringAsFixed(1),
                            style: AppTextStyles.geistExtraExtraLargeExtraBold
                                .copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AppGaps.w20,
                Expanded(
                  child: RShadowContainer(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.w10,
                        vertical: AppSizes.h10,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("WEIGHT"),
                          Text(
                            weight.toStringAsFixed(1),
                            style: AppTextStyles.geistExtraExtraLargeExtraBold
                                .copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
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
