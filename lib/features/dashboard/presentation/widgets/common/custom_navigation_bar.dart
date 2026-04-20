import 'package:flutter/cupertino.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';

import '../../../../../common/resources/app_resources/app_sizes.dart';

class RNavigationBar extends StatelessWidget {
  final List<RNavigationButtons> buttons;

  const RNavigationBar({
    super.key,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
          color: AppColors.black,
          width: AppSizes.v2,
        ),
      )),
      height: AppSizes.h70,
      width: double.infinity,
      child: Row(
        children: buttons,
      ),
    );
  }
}

class RNavigationButtons extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const RNavigationButtons({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: double.infinity,
        color: isActive ? AppColors.primary : AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppSizes.v22,
              color: isActive ? AppColors.white : AppColors.black,
            ),
            Text(
              label,
              style: AppTextStyles.geistSmallSemiBold.copyWith(
                  color: isActive ? AppColors.white : AppColors.black,
                  letterSpacing: -0.5),
            ),
          ],
        ),
      ),
    ));
  }
}
