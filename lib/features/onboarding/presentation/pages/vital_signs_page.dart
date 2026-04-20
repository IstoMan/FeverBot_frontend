import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifesto/common/resources/app_resources/app_strings.dart';
import 'package:manifesto/common/widgets/elevated_button.dart';
import 'package:manifesto/common/widgets/text_field.dart';
import 'package:manifesto/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:manifesto/features/onboarding/presentation/widgets/description_container.dart';
import 'package:manifesto/features/onboarding/presentation/widgets/vital_sign_banner.dart';
import 'package:manifesto/features/onboarding/presentation/widgets/vital_sign_container.dart';

import '../../../../common/resources/app_resources/app_colors.dart';
import '../../../../common/resources/app_resources/app_gaps.dart';
import '../../../../common/resources/app_resources/app_sizes.dart';
import '../../../../common/resources/app_resources/app_text_styles.dart';
import 'habits_page.dart';

class VitalSignsPage extends GetView<OnboardingController> {
  const VitalSignsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.appBarText),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGaps.h20,
              Text(
                "VITAL",
                style: AppTextStyles.geistExtraExtraLargeRegular.copyWith(
                    fontSize: AppSizes.f48,
                    color: AppColors.black,
                    height: 1.0),
              ),
              Text(
                "SIGNS",
                style: AppTextStyles.geistExtraExtraLargeRegular.copyWith(
                    fontSize: AppSizes.f48,
                    color: AppColors.primary,
                    height: 1.0),
              ),
              AppGaps.h20,
              const DescriptionContainer(
                  data:
                      "Quantify your baseline. We use clinical-grade metrics to calibrate your biological manifest. Precision starts with data."),
              AppGaps.h30,
              const RVitalSignBanner(),
              AppGaps.h30,
              const RVitalSignContainer(
                icon: Icons.heart_broken,
                label: 'BLOOD PRESSURE',
                textFields: [
                  RTextField(label: "SYSTOLIC (MMHG)", hint: "120"),
                  RTextField(label: "DIASTOLIC (MMHG)", hint: "80")
                ],
              ),
              AppGaps.h30,
              const RVitalSignContainer(
                icon: Icons.heart_broken,
                label: 'CHOLESTEROL LEVEL',
                textFields: [
                  RTextField(label: "TOTAL CHOLESTEROL (MG/DL)", hint: "190"),
                ],
              ),
              AppGaps.h30,
              const RVitalSignContainer(
                icon: Icons.heart_broken,
                label: 'GLUCOSE LEVEL',
                textFields: [
                  RTextField(label: "FASTING GLUCOSE (MG/DL)", hint: "95"),
                ],
              ),
              AppGaps.h50,
              SizedBox(
                width: double.infinity,
                child: RElevatedButton(
                  label: "Continue to Step 3",
                  onPressed: () => Get.to(() => const HabitsPage()),
                ),
              ),
              AppGaps.h50,
            ],
          ),
        ),
      ),
    );
  }
}
