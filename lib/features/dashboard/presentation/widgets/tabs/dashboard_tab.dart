import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/features/dashboard/presentation/controllers/dashboard_controller.dart';

import '../dashboard/dial_container.dart';

class DashboardTab extends GetView<DashboardController> {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.w15),
      child: Column(
        children: [
          AppGaps.h50,
          controller.state.riskScore.value != null
              ? Obx(
                  () => DialContainer(
                    riskScore: controller.state.riskScore.value!.riskScore,
                    riskClass: controller.state.riskScore.value!.riskClass,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
