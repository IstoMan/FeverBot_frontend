import 'package:flutter/material.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/widgets/shadow_container.dart';
import 'package:manifesto/common/widgets/text_field.dart';

import '../../../../common/resources/app_resources/app_sizes.dart';
import '../../../../common/resources/app_resources/app_text_styles.dart';

class RVitalSignContainer extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<RTextField> textFields;

  const RVitalSignContainer({
    super.key,
    required this.icon,
    required this.label,
    required this.textFields,
  });

  @override
  Widget build(BuildContext context) {
    return RShadowContainer(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.h30,
          horizontal: AppSizes.w30,
        ),
        decoration: const BoxDecoration(color: AppColors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  size: AppSizes.v30,
                  icon,
                  color: AppColors.primary,
                ),
                AppGaps.w10,
                Expanded(
                  child: Text(
                    maxLines: 2,
                    label,
                    style: AppTextStyles.geistExtraExtraLargeExtraBold
                        .copyWith(color: AppColors.black, letterSpacing: -0.6),
                  ),
                ),
              ],
            ),
            AppGaps.h30,
            Column(
              children: [
                for (int i = 0; i < textFields.length; i += 2)
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: i + 2 < textFields.length ? AppSizes.h10 : 0),
                    child: Row(
                      children: [
                        Expanded(child: textFields[i]),
                        if (i + 1 < textFields.length) ...[
                          AppGaps.w20,
                          Expanded(child: textFields[i + 1]),
                        ],
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
