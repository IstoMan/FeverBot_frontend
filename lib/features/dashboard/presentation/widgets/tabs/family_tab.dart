import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/common/family_member.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/common/relation_dialog.dart';

import '../../../../../common/resources/app_resources/app_colors.dart';
import '../../../../../common/resources/app_resources/app_gaps.dart';
import '../../../../../common/resources/app_resources/app_text_styles.dart';
import '../../../../../common/widgets/elevated_button.dart';
import '../../../../onboarding/presentation/widgets/description_container.dart';
import '../common/scan_qe_dialog.dart';

class FamilyTab extends GetView<DashboardController> {
  const FamilyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.w15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGaps.h20,
            Text(
              "MANAGE",
              style: AppTextStyles.geistExtraExtraLargeRegular.copyWith(
                fontSize: AppSizes.f48,
                color: AppColors.black,
                height: 1.0,
              ),
            ),
            Text(
              "FAMILY",
              style: AppTextStyles.geistExtraExtraLargeRegular.copyWith(
                fontSize: AppSizes.f48,
                color: AppColors.primary,
                height: 1.0,
              ),
            ),
            AppGaps.h20,
            const DescriptionContainer(
              data:
                  "Invite household members, share biometric updates, and keep everyone aligned on care.",
            ),
            AppGaps.h30,
            SizedBox(
              width: double.infinity,
              child: Obx(
                () => RElevatedButton(
                  isLoading: controller.state.invitingMember.value,
                  onPressed: () => RelationDialog.show(
                    onPressed: controller.createInvitation,
                  ),
                  label: 'Invite',
                ),
              ),
            ),
            Obx(
              () => controller.state.family.value == null
                  ? Column(
                      children: [
                        AppGaps.h25,
                        SizedBox(
                          width: double.infinity,
                          child: RElevatedButton(
                            isLoading: controller.state.invitingMember.value,
                            onPressed: () =>
                                ScanQeDialog.show(onDetect: controller.scanQR),
                            label: 'Scan',
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            AppGaps.h30,
            Obx(
              () {
                final members = controller.state.family.value?.members ?? [];
                if (members.isEmpty) return const SizedBox.shrink();
                return Column(
                  children: [
                    for (var i = 0; i < members.length; i++) ...[
                      if (i > 0) AppGaps.h20,
                      FamilyMember(
                        member: members[i],
                        onPressed: controller.deleteMember,
                      ),
                    ],
                  ],
                );
              },
            ),
            AppGaps.h30,
          ],
        ),
      ),
    );
  }
}
