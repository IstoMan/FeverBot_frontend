import 'package:flutter/material.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';
import 'package:manifesto/common/widgets/shadow_container.dart';
import 'package:manifesto/features/dashboard/domain/entities/family_entity.dart';

class FamilyMember extends StatelessWidget {
  final Function(String)? onPressed;
  final FamilyMemberEntity member;

  const FamilyMember({
    super.key,
    this.onPressed,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return RShadowContainer(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.w30,
          vertical: AppSizes.h30,
        ),
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              member.role.toUpperCase(),
              style: AppTextStyles.geistNormalBold.copyWith(
                letterSpacing: 1.4,
                color: AppColors.primary,
              ),
            ),
            AppGaps.h4,
            Text(
              member.name.toUpperCase(),
              style: AppTextStyles.geistExtraExtraLargeExtraBold.copyWith(
                height: 1,
                letterSpacing: -0.75,
                fontSize: AppSizes.f30,
                color: AppColors.black,
              ),
            ),
            AppGaps.h30,
            Semantics(
              button: true,
              label: "Delete ${member.name}",
              child: GestureDetector(
                onTap: () => onPressed?.call(member.uuid),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.delete_outline,
                      size: AppSizes.v18,
                      color: const Color(0xFFA1A1AA),
                    ),
                    AppGaps.w2,
                    Text(
                      "DELETE",
                      style: AppTextStyles.geistSmallBold.copyWith(
                        color: const Color(0xFFA1A1AA),
                        letterSpacing: 1.2,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
