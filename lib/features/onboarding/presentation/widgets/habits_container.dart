import 'package:flutter/material.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';
import 'package:manifesto/common/widgets/shadow_container.dart';

class RHabitsContainer extends StatelessWidget {
  final String label;
  final String description;
  final bool yes;
  final VoidCallback? onYes;
  final VoidCallback? onNo;

  const RHabitsContainer({
    super.key,
    required this.yes,
    required this.label,
    required this.description,
    this.onYes,
    this.onNo,
  });

  @override
  Widget build(BuildContext context) {
    return RShadowContainer(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.w30,
          vertical: AppSizes.h25,
        ),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.geistExtraLargeBold
                  .copyWith(color: AppColors.black, letterSpacing: -0.6),
            ),
            Text(
              description,
              style: AppTextStyles.geistSmallMedium.copyWith(
                color: AppColors.black,
              ),
            ),
            AppGaps.h20,
            Row(
              children: [
                _AnimatedHabitButton(
                  label: "YES",
                  isSelected: yes,
                  onPressed: onYes,
                ),
                _AnimatedHabitButton(
                  label: "NO",
                  isSelected: !yes,
                  onPressed: onNo,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _AnimatedHabitButton extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onPressed;

  const _AnimatedHabitButton({
    required this.label,
    required this.isSelected,
    this.onPressed,
  });

  @override
  State<_AnimatedHabitButton> createState() => _AnimatedHabitButtonState();
}

class _AnimatedHabitButtonState extends State<_AnimatedHabitButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _pressed ? 0.93 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.h15,
            horizontal: AppSizes.w20,
          ),
          decoration: BoxDecoration(
            color: widget.isSelected ? AppColors.primary : AppColors.white,
            border: Border.all(color: AppColors.black, width: 2),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            style: AppTextStyles.geistLargeExtraBold.copyWith(
              color: widget.isSelected ? AppColors.white : AppColors.black,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
