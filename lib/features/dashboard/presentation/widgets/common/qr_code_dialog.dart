import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/widgets/elevated_button.dart';

import '../../../../../common/resources/app_resources/app_colors.dart';
import '../../../../../common/resources/app_resources/app_text_styles.dart';

class QrCodeDialog {
  static show({
    required String imageBase64,
    VoidCallback? onShare,
  }) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.scaffoldBg,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.v20,
            horizontal: AppSizes.w20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Here is shareable QR code!",
                style: AppTextStyles.geistNormalBold.copyWith(
                  color: AppColors.black,
                ),
              ),
              AppGaps.h10,
              Image.memory(
                base64Decode(
                  imageBase64,
                ),
              ),
              AppGaps.h20,
              SizedBox(
                width: double.infinity,
                child: RElevatedButton(
                  label: "Share",
                  onPressed: onShare,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
