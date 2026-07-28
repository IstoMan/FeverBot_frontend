import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';

class RTextTheme {
  RTextTheme._();

  /// Defines the text theme for the light mode of the application.
  static final TextTheme lightTextTheme = TextTheme(
    // Display Styles: Used for large, prominent text, like headlines on a landing page.
    displayLarge: AppTextStyles.geistExtraExtraLargeExtraBold
        .copyWith(color: AppColors.black),
    displayMedium:
        AppTextStyles.geistExtraLargeExtraBold.copyWith(color: AppColors.black),
    displaySmall:
        AppTextStyles.geistLargeExtraBold.copyWith(color: AppColors.black),

    // Headline Styles: Suitable for headlines in standard app screens.
    headlineLarge:
        AppTextStyles.geistLargeBold.copyWith(color: AppColors.black),
    headlineMedium:
        AppTextStyles.geistMediumBold.copyWith(color: AppColors.black),
    headlineSmall:
        AppTextStyles.geistNormalBold.copyWith(color: AppColors.black),

    // Title Styles: Typically used for titles of components like AppBars or Cards.
    titleLarge: AppTextStyles.geistLargeBold.copyWith(color: AppColors.black),
    titleMedium: AppTextStyles.geistNormalBold.copyWith(color: AppColors.black),
    titleSmall: AppTextStyles.geistSmallBold.copyWith(color: AppColors.black),

    // Body Styles: The default styles for most text content in the app.
    bodyLarge:
        AppTextStyles.geistNormalRegular.copyWith(color: AppColors.black),
    bodyMedium:
        AppTextStyles.geistSmallRegular.copyWith(color: AppColors.black),
    bodySmall:
        AppTextStyles.geistExtraSmallRegular.copyWith(color: AppColors.black),

    // Label Styles: Used for text on buttons, or as labels for form fields.
    labelLarge:
        AppTextStyles.geistNormalMedium.copyWith(color: AppColors.black),
    labelMedium:
        AppTextStyles.geistSmallMedium.copyWith(color: AppColors.black),
    labelSmall:
        AppTextStyles.geistExtraSmallMedium.copyWith(color: AppColors.black),
  );

  /// Defines the text theme for the dark mode of the application.
  static final TextTheme darkTextTheme = TextTheme(
    // Display Styles: Used for large, prominent text, like headlines on a landing page.
    displayLarge: AppTextStyles.geistExtraExtraLargeExtraBold,
    displayMedium: AppTextStyles.geistExtraLargeExtraBold,
    displaySmall: AppTextStyles.geistLargeExtraBold,

    // Headline Styles: Suitable for headlines in standard app screens.
    headlineLarge: AppTextStyles.geistLargeBold,
    headlineMedium: AppTextStyles.geistMediumBold,
    headlineSmall: AppTextStyles.geistNormalBold,

    // Title Styles: Typically used for titles of components like AppBars or Cards.
    titleLarge: AppTextStyles.geistLargeBold,
    titleMedium: AppTextStyles.geistNormalBold,
    titleSmall: AppTextStyles.geistSmallBold,

    // Body Styles: The default styles for most text content in the app.
    bodyLarge: AppTextStyles.geistNormalRegular,
    bodyMedium: AppTextStyles.geistSmallRegular,
    bodySmall: AppTextStyles.geistExtraSmallRegular,

    // Label Styles: Used for text on buttons, or as labels for form fields.
    labelLarge: AppTextStyles.geistNormalMedium,
    labelMedium: AppTextStyles.geistSmallMedium,
    labelSmall: AppTextStyles.geistExtraSmallMedium,
  );
}
