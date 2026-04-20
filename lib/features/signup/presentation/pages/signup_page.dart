import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:manifesto/common/resources/app_resources/app_strings.dart';
import 'package:manifesto/common/widgets/text_field.dart';
import 'package:manifesto/features/signup/presentation/controllers/signup_controller.dart';

import '../../../../common/resources/app_resources/app_colors.dart';
import '../../../../common/resources/app_resources/app_gaps.dart';
import '../../../../common/resources/app_resources/app_sizes.dart';
import '../../../../common/resources/app_resources/app_text_styles.dart';
import '../../../../common/widgets/elevated_button.dart';
import '../../../../routes/app_routes.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(AppStrings.appBarText),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.w15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGaps.h50,
              Text(
                "Create Account",
                style: AppTextStyles.geistExtraExtraLargeExtraBold.copyWith(
                    color: AppColors.black,
                    fontSize: AppSizes.f28,
                    letterSpacing: -0.7),
              ),
              Text(
                "Join the technical manual for the future of digital development.",
                style: AppTextStyles.geistNormalLight.copyWith(
                  color: AppColors.black,
                ),
              ),
              AppGaps.h20,
              const RTextField(
                label: "FULL NAME",
                hint: "Keshav Sharma",
                icon: Icons.person,
              ),
              AppGaps.h20,
              const RTextField(
                label: "EMAIL ADDRESS",
                hint: "name@comapny.com",
                icon: Icons.mail_outline,
              ),
              AppGaps.h20,
              const RTextField(
                label: "SECURITY KEY",
                hint: "",
                icon: Icons.lock_outline,
              ),
              AppGaps.h30,
              SizedBox(
                width: double.infinity,
                child: RElevatedButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.onboarding),
                  label: "CONTINUE",
                ),
              ),
              AppGaps.h30,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: AppTextStyles.geistNormalRegular.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.offNamed(AppRoutes.login),
                    child: const Text(
                      "Log In",
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
