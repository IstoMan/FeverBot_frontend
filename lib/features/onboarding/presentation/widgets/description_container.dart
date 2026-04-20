import 'package:flutter/material.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';

class DescriptionContainer extends StatelessWidget {
  final String data;

  const DescriptionContainer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.w10,
        vertical: AppSizes.h5,
      ),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: AppColors.primary,
            width: AppSizes.w5,
          ),
        ),
      ),
      child: Text(
        data,
        style: AppTextStyles.geistNormalRegular.copyWith(
          color: AppColors.black,
        ),
      ),
    );
  }
}
