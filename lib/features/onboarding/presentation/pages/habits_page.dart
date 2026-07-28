import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:manifesto/common/resources/app_resources/app_strings.dart';
import 'package:manifesto/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:manifesto/features/onboarding/presentation/widgets/habits_container.dart';

import '../../../../common/resources/app_resources/app_colors.dart';
import '../../../../common/resources/app_resources/app_gaps.dart';
import '../../../../common/resources/app_resources/app_sizes.dart';
import '../../../../common/resources/app_resources/app_text_styles.dart';
import '../../../../common/widgets/elevated_button.dart';
import '../widgets/description_container.dart';

class HabitsPage extends GetView<OnboardingController> {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appBarText),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGaps.h20,
              Text(
                "HABITS &",
                style: AppTextStyles.geistExtraExtraLargeRegular.copyWith(
                    fontSize: AppSizes.f48,
                    color: AppColors.black,
                    height: 1.0),
              ),
              Text(
                "ACTIVITY",
                style: AppTextStyles.geistExtraExtraLargeRegular.copyWith(
                    fontSize: AppSizes.f48,
                    color: AppColors.primary,
                    height: 1.0),
              ),
              AppGaps.h20,
              const DescriptionContainer(
                  data:
                      "Complete your digital profile by documenting your biological routine. We prioritize raw data integrity."),
              AppGaps.h30,
              Obx(
                () => RHabitsContainer(
                  onYes: () => controller.state.smokeYes.value = true,
                  onNo: () => controller.state.smokeYes.value = false,
                  yes: controller.state.smokeYes.value,
                  label: "DO YOU SMOKE?",
                  description:
                      "Includes traditional and electronic delivery systems.",
                ),
              ),
              AppGaps.h30,
              Obx(
                () => RHabitsContainer(
                  onYes: () => controller.state.alcoholYes.value = true,
                  onNo: () => controller.state.alcoholYes.value = false,
                  yes: controller.state.alcoholYes.value,
                  label: "DO YOU DRINK ALCOHOL?",
                  description: "Social or regular consumption patterns.",
                ),
              ),
              AppGaps.h30,
              Obx(
                () => RHabitsContainer(
                  onYes: () => controller.state.activeYes.value = true,
                  onNo: () => controller.state.activeYes.value = false,
                  yes: controller.state.activeYes.value,
                  label: "ARE YOU PHYSICALLY ACTIVE?",
                  description:
                      "Engaging in moderate to intense exercise 3x per week.",
                ),
              ),
              AppGaps.h30,
              SizedBox(
                width: double.infinity,
                child: RElevatedButton(
                  label: "Complete Profile",
                  onPressed: controller.completeProfile,
                ),
              ),
              AppGaps.h50
            ],
          ),
        ),
      ),
      ),
    );
  }
}
