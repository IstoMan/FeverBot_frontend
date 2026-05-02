import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_strings.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';
import 'package:manifesto/common/widgets/text_field.dart';
import 'package:manifesto/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:manifesto/features/onboarding/presentation/pages/vital_signs_page.dart';
import 'package:manifesto/features/onboarding/presentation/widgets/gender_button.dart';

import '../../../../common/resources/app_resources/app_gaps.dart';
import '../../../../common/widgets/elevated_button.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
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
                "TELL US",
                style: AppTextStyles.geistExtraExtraLargeRegular.copyWith(
                    fontSize: AppSizes.f48,
                    color: AppColors.black,
                    height: 1.0),
              ),
              Text(
                "ABOUT",
                style: AppTextStyles.geistExtraExtraLargeRegular.copyWith(
                    fontSize: AppSizes.f48,
                    color: AppColors.black,
                    height: 1.0),
              ),
              Text(
                "YOURSELF",
                style: AppTextStyles.geistExtraExtraLargeRegular.copyWith(
                    fontSize: AppSizes.f48,
                    color: AppColors.primary,
                    height: 1.0),
              ),
              AppGaps.h30,
              RTextField(
                inputType: TextInputType.number,
                controller: controller.state.ageController,
                label: "AGE (YEARS)",
                hint: "25",
              ),
              AppGaps.h30,
              Text(
                "GENDER IDENTITY",
                style: AppTextStyles.geistSmallRegular
                    .copyWith(letterSpacing: 1.2, color: AppColors.black),
              ),
              AppGaps.h8,
              Obx(
                () => Row(
                  spacing: AppSizes.w15,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RGenderButton(
                        onTap: () =>
                            controller.state.selectedGender.value = "MALE",
                        isSelected:
                            controller.state.selectedGender.value == "MALE",
                        icon: Icons.male,
                        label: 'MALE',
                      ),
                    ),
                    Expanded(
                      child: RGenderButton(
                        onTap: () =>
                            controller.state.selectedGender.value = "FEMALE",
                        isSelected:
                            controller.state.selectedGender.value == "FEMALE",
                        icon: Icons.male,
                        label: 'FEMALE',
                      ),
                    ),
                    Expanded(
                      child: RGenderButton(
                        onTap: () =>
                            controller.state.selectedGender.value = "OTHERS",
                        isSelected:
                            controller.state.selectedGender.value == "OTHERS",
                        icon: Icons.male,
                        label: 'OTHERS',
                      ),
                    )
                  ],
                ),
              ),
              AppGaps.h30,
              RTextField(
                controller: controller.state.heightController,
                label: "HEIGHT (CM)",
                hint: "180",
              ),
              AppGaps.h20,
              RTextField(
                controller: controller.state.weightController,
                label: "WEIGHT (KG)",
                hint: "75",
              ),
              AppGaps.h30,
              SizedBox(
                width: double.infinity,
                child: RElevatedButton(
                  onPressed: () => Get.to(() => const VitalSignsPage()),
                  label: 'Continue to Step 2',
                ),
              ),
              AppGaps.h50
            ],
          ),
        ),
      ),
    );
  }
}
