import 'package:flutter/material.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';

class RTextFormFieldTheme {
  RTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    filled: true,
    fillColor: AppColors.white,

    // Icon colors
    prefixIconColor: AppColors.primary,
    suffixIconColor: AppColors.primary,

    hintStyle: AppTextStyles.geistNormalRegular.copyWith(
      color: const Color(0x805B403A),
    ),
    labelStyle: AppTextStyles.geistExtraSmallMedium.copyWith(
      color: AppColors.black2,
    ),
    floatingLabelStyle: AppTextStyles.geistExtraSmallMedium.copyWith(
      color: AppColors.primary,
    ),
    errorStyle: AppTextStyles.geistExtraSmallRegular.copyWith(
      color: AppColors.red,
      height: 1.2,
    ),
    helperStyle: AppTextStyles.geistExtraSmallRegular.copyWith(
      color: AppColors.black4,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide.none,
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSizes.w16,
      vertical: AppSizes.h10,
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    filled: true,
    fillColor: AppColors.black6,

    // Icon colors
    prefixIconColor: AppColors.primary,
    suffixIconColor: AppColors.primary,

    // Text styles
    hintStyle: AppTextStyles.geistNormalRegular.copyWith(
      color: AppColors.white2,
    ),
    labelStyle: AppTextStyles.geistExtraSmallMedium.copyWith(
      color: AppColors.white2,
    ),
    floatingLabelStyle: AppTextStyles.geistExtraSmallMedium.copyWith(
      color: AppColors.primary,
    ),
    errorStyle: AppTextStyles.geistExtraSmallRegular.copyWith(
      color: AppColors.red,
      height: 1.2,
    ),
    helperStyle: AppTextStyles.geistExtraSmallRegular.copyWith(
      color: AppColors.white2,
    ),

    // Content padding
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSizes.h16,
      vertical: AppSizes.v12,
    ),

    // Borders
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r8),
      borderSide: BorderSide(color: AppColors.primary, width: AppSizes.w1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r8),
      borderSide: BorderSide(color: AppColors.primary, width: AppSizes.w1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r8),
      borderSide: BorderSide(color: AppColors.primary, width: AppSizes.w2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r8),
      borderSide: BorderSide(color: AppColors.red, width: AppSizes.w1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r8),
      borderSide: BorderSide(color: AppColors.red, width: AppSizes.w2),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r8),
      borderSide: BorderSide(color: AppColors.white2, width: AppSizes.w1),
    ),
  );

  // Custom theme for specific use cases
  static InputDecorationTheme searchFieldTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.black6,
    hintStyle: AppTextStyles.geistSmallRegular.copyWith(
      color: AppColors.white2,
    ),
    prefixIconColor: AppColors.primary,
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSizes.h12,
      vertical: AppSizes.v12,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r8),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r8),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r8),
      borderSide: BorderSide(color: AppColors.primary, width: AppSizes.w1),
    ),
  );
}
