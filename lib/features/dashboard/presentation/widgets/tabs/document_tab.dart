import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/features/dashboard/presentation/controllers/dashboard_controller.dart';

import '../../../../../common/resources/app_resources/app_colors.dart';
import '../../../../../common/resources/app_resources/app_text_styles.dart';
import '../../../../onboarding/presentation/widgets/description_container.dart';

class DocumentTab extends GetView<DashboardController> {
  const DocumentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: AppSizes.w15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGaps.h20,
            Text(
              "DOCUMENT",
              style: AppTextStyles.geistExtraExtraLargeRegular.copyWith(
                fontSize: AppSizes.f48,
                color: AppColors.black,
                height: 1.0,
              ),
            ),
            Text(
              "ARCHIVE",
              style: AppTextStyles.geistExtraExtraLargeRegular.copyWith(
                  fontSize: AppSizes.f48,
                  color: AppColors.primary,
                  height: 1.0),
            ),
            AppGaps.h20,
            const DescriptionContainer(
              data:
                  "Administrative management of the nuclear health unit. Manage permissions, dietary overrides, and biometric sharing protocols for all linked members.",
            ),
          ],
        ),
      ),
    );
  }
}
