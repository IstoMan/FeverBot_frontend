import 'package:flutter/material.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';
import 'package:manifesto/common/widgets/shadow_container.dart';

import '../resources/app_resources/app_gaps.dart';

class RTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final IconData? icon;

  const RTextField({
    super.key,
    this.label,
    required this.hint,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Text(
                label!,
                style: AppTextStyles.geistSmallRegular
                    .copyWith(letterSpacing: 1.2, color: AppColors.black),
              )
            : const SizedBox.shrink(),
        AppGaps.h8,
        RShadowContainer(
          enableBorder: true,
          enableShadow: true,
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: icon != null ? Icon(icon) : null,
              hintText: hint,
            ),
          ),
        )
      ],
    );
  }
}
