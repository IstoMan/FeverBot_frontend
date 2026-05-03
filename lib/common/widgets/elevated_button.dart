import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/widgets/shadow_container.dart';

class RElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const RElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return RShadowContainer(
      enableBorder: false,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFAF2900),
              Color(0xFFD63C10),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: ElevatedButton.icon(
          onPressed: isLoading ? () {} : onPressed,
          label: isLoading
              ? LoadingAnimationWidget.threeArchedCircle(
                  color: AppColors.white,
                  size: AppSizes.v20,
                )
              : const Icon(Icons.arrow_forward),
          icon: Text(label),
        ),
      ),
    );
  }
}
