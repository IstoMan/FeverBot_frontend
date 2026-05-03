import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';
import 'package:manifesto/common/widgets/elevated_button.dart';
import 'package:manifesto/common/widgets/text_field.dart';

class RelationDialog {
  static show({
    required Function(String)? onPressed,
  }) {
    TextEditingController relationController = TextEditingController();
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.w20,
          vertical: AppSizes.h20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        backgroundColor: AppColors.scaffoldBg,
        title: Text(
          "What's your relation?",
          style: AppTextStyles.geistNormalBold.copyWith(
            color: AppColors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RTextField(
              hint: "Mother",
              controller: relationController,
            ),
            AppGaps.h30,
            Row(
              children: [
                Expanded(
                  child: RElevatedButton(
                    label: "Cancel",
                    onPressed: () => Get.back(),
                  ),
                ),
                AppGaps.w15,
                Expanded(
                  child: RElevatedButton(
                    label: "Invite",
                    onPressed: () {
                      onPressed?.call(relationController.text);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
