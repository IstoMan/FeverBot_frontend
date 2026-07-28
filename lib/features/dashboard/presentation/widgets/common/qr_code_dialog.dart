import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/widgets/elevated_button.dart';

import '../../../../../common/resources/app_resources/app_colors.dart';
import '../../../../../common/resources/app_resources/app_text_styles.dart';

class QrCodeDialog {
  static Uint8List decodeQrBytes(String imageBase64) {
    final payload = imageBase64.contains(',')
        ? imageBase64.split(',').last
        : imageBase64;
    return base64Decode(payload);
  }

  static show({
    required String imageBase64,
    Uint8List? decodedBytes,
    VoidCallback? onShare,
  }) {
    final bytes = decodedBytes ?? decodeQrBytes(imageBase64);
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
                bytes,
                cacheWidth: 512,
                cacheHeight: 512,
                gaplessPlayback: true,
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
