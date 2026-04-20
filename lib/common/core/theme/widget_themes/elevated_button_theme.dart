import 'package:flutter/material.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';

class RElevatedButtonTheme {
  RElevatedButtonTheme._();

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.transparent,
        foregroundColor: AppColors.white,
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.h16,
          horizontal: AppSizes.h24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        textStyle:
            AppTextStyles.geistNormalSemiBold.copyWith(letterSpacing: 1.4)),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2,
      shadowColor: AppColors.primaryDark,
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.primary,
      disabledForegroundColor: AppColors.white2,
      disabledBackgroundColor: AppColors.black3,
      side: const BorderSide(color: AppColors.primary),
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.v16,
        horizontal: AppSizes.h24,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r8)),
      surfaceTintColor: AppColors.primary,
    ),
  );
}
