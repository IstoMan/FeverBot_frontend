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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.w15,
            ),
            child: Form(
              key: controller.state.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppGaps.h40,
                  Text(
                    AppStrings.appBarText,
                    style: AppTextStyles.geistExtraExtraLargeExtraBold.copyWith(
                      color: AppColors.primary,
                      fontSize: AppSizes.f48,
                      height: 1.0,
                      letterSpacing: -1.2,
                    ),
                  ),
                  AppGaps.h8,
                  Text(
                    AppStrings.tagline,
                    style: AppTextStyles.geistNormalLight.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  AppGaps.h30,
                  Text(
                    "Create Account",
                    style: AppTextStyles.geistExtraExtraLargeExtraBold.copyWith(
                      color: AppColors.black,
                      fontSize: AppSizes.f24,
                      letterSpacing: -0.7,
                    ),
                  ),
                  AppGaps.h20,
                  RTextField(
                    controller: controller.state.nameController,
                    label: "FULL NAME",
                    hint: "Keshav Sharma",
                    icon: Icons.person,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                  ),
                  AppGaps.h20,
                  RTextField(
                    controller: controller.state.emailController,
                    label: "EMAIL ADDRESS",
                    hint: "name@company.com",
                    icon: Icons.mail_outline,
                    inputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email is required";
                      }
                      if (!GetUtils.isEmail(value.trim())) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  AppGaps.h20,
                  RTextField(
                    controller: controller.state.passwordController,
                    label: "PASSWORD",
                    hint: "",
                    icon: Icons.lock_outline,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  AppGaps.h30,
                  SizedBox(
                    width: double.infinity,
                    child: RElevatedButton(
                      onPressed: () {
                        if (controller.state.formKey.currentState?.validate() ??
                            false) {
                          controller.signup();
                        }
                      },
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
        ),
      ),
    );
  }
}
