import 'package:flutter/material.dart';
import 'package:get/Get.dart';
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: AppSizes.w15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGaps.h50,
              Text(
                "Welcome Back",
                style: AppTextStyles.geistExtraExtraLargeExtraBold.copyWith(
                    color: AppColors.black,
                    fontSize: AppSizes.f28,
                    letterSpacing: -0.7),
              ),
              Text(
                "Enter your credentials to access the terminal and continue your contribution to the manifest.",
                style: AppTextStyles.geistNormalLight.copyWith(
                  color: AppColors.black,
                ),
              ),
              AppGaps.h20,
              RTextField(
                controller: controller.state.emailController,
                icon: Icons.mail_outline,
                hint: "name@comapny.com",
                label: "EMAIL ADDRESS",
              ),
              AppGaps.h20,
              RTextField(
                controller: controller.state.passwordController,
                icon: Icons.lock_outline,
                hint: "abcd1234",
                label: "PASSWORD",
              ),
              AppGaps.h30,
              SizedBox(
                width: double.infinity,
                child: RElevatedButton(
                  onPressed: controller.fetchLoginData,
                  label: "Login",
                ),
              ),
              AppGaps.h30,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont't have an account?",
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
    );
  }
}
