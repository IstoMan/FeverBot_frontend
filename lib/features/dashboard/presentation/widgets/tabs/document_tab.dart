import 'package:flutter/material.dart';
import 'package:get/Get.dart';
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
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
                  height: 1.0,
                ),
              ),
              AppGaps.h20,
              const DescriptionContainer(
                data:
                    "Store lab results, prescriptions, and visit notes in one place. Upload support is coming soon.",
              ),
              AppGaps.h40,
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.folder_open_outlined,
                      size: AppSizes.v60,
                      color: AppColors.black.withOpacity(0.35),
                    ),
                    AppGaps.h16,
                    Text(
                      "No documents yet",
                      style: AppTextStyles.geistLargeBold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    AppGaps.h8,
                    Text(
                      "Your health files will appear here once uploads are available.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.geistNormalLight.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              AppGaps.h30,
            ],
          ),
        ),
      ),
    );
  }
}
