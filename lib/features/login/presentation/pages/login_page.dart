import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';
import 'package:manifesto/common/widgets/elevated_button.dart';
import 'package:manifesto/common/widgets/text_field.dart';
import 'package:manifesto/features/login/presentation/controllers/login_controller.dart';
import 'package:manifesto/routes/app_routes.dart';

import '../../../../common/resources/app_resources/app_strings.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(AppStrings.appBarText),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
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
                    "Welcome Back",
                    style: AppTextStyles.geistExtraExtraLargeExtraBold.copyWith(
                      color: AppColors.black,
                      fontSize: AppSizes.f24,
                      letterSpacing: -0.7,
                    ),
                  ),
                  AppGaps.h8,
                  Text(
                    "Sign in to check your risk score and continue your health journey.",
                    style: AppTextStyles.geistNormalLight.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  AppGaps.h20,
                  RTextField(
                    controller: controller.state.emailController,
                    icon: Icons.mail_outline,
                    hint: "name@company.com",
                    label: "EMAIL ADDRESS",
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
                    icon: Icons.lock_outline,
                    hint: "abcd1234",
                    label: "PASSWORD",
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                  ),
                  AppGaps.h30,
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => RElevatedButton(
                        isLoading: controller.state.isLoading.value,
                        onPressed: () {
                          if (controller.state.formKey.currentState
                                  ?.validate() ??
                              false) {
                            controller.fetchLoginData();
                          }
                        },
                        label: "Login",
                      ),
                    ),
                  ),
                  AppGaps.h30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppTextStyles.geistNormalRegular.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.offNamed(AppRoutes.signup),
                        child: const Text("Sign Up"),
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
