import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Shared gradients for FeverBot
class AppGradients {
  static const primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.primary,
      AppColors.primaryVariant,
    ],
  );
  static const blackGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    colors: [
      AppColors.black,
    ],
  );
}
