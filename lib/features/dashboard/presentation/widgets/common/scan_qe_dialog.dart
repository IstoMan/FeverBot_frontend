import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../common/resources/app_resources/app_colors.dart';
import '../../../../../common/resources/app_resources/app_sizes.dart';
import '../../../../../common/resources/app_resources/app_text_styles.dart';

class ScanQeDialog {
  static Future<void> show({
    required Function(BarcodeCapture)? onDetect,
  }) async {
    bool detected = false;
    final controller = MobileScannerController();

    await Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.scaffoldBg,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.v20,
            horizontal: AppSizes.w10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Scan the QR code to join family!",
                style: AppTextStyles.geistNormalBold.copyWith(
                  color: AppColors.black,
                ),
              ),
              AppGaps.h20,
              SizedBox(
                height: AppSizes.h342,
                width: AppSizes.w350,
                child: MobileScanner(
                  controller: controller,
                  onDetect: (capture) {
                    if (detected) return;
                    detected = true;
                    onDetect?.call(capture);
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );

    await controller.dispose();
  }
}
