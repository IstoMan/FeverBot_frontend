import 'package:flutter/material.dart';

import '../../../../common/resources/app_resources/app_colors.dart';
import '../../../../common/resources/app_resources/app_sizes.dart';
import '../../../../common/resources/app_resources/app_text_styles.dart';
import '../../../../common/widgets/shadow_container.dart';

class RGenderButton extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const RGenderButton({
    super.key,
    this.isSelected = false,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: onTap,
        child: RShadowContainer(
          enableBorder: !isSelected,
          enableShadow: !isSelected,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            color: isSelected ? AppColors.primary : AppColors.white,
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.w10,
              vertical: AppSizes.h20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Icon(
                      icon,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  style: AppTextStyles.geistMediumBold.copyWith(
                    color: isSelected ? AppColors.white : AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
