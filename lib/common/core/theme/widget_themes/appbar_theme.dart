import 'package:flutter/material.dart';
import 'package:manifesto/common//resources/app_resources/app_colors.dart';
import 'package:manifesto/common//resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';

class RAppBarTheme {
  RAppBarTheme._();

  static AppBarThemeData lightAppBarTheme = AppBarThemeData(
    elevation: 0,
    toolbarHeight: AppSizes.h60,
    titleTextStyle: AppTextStyles.geistExtraLargeBlack.copyWith(
      color: AppColors.primary,
      letterSpacing: -0.5,
    ),
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    shape: const Border(
      bottom: BorderSide(color: AppColors.black, width: 5),
    ),
  );

  static AppBarThemeData darkAppBarTheme = AppBarThemeData(
    elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.white, size: AppSizes.v24),
    actionsIconTheme:
        IconThemeData(color: AppColors.primary, size: AppSizes.v24),
  );
}
