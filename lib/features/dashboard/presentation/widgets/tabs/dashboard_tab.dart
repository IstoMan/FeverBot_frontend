import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/dashboard/metrics_container.dart';

import '../dashboard/dial_container.dart';

class DashboardTab extends GetView<DashboardController> {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.w15),
        child: Obx(
          () => controller.state.user.value == null
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    AppGaps.h30,
                    DialContainer(
                      riskScore: controller.state.user.value!.riskScore,
                      riskClass:
                          controller.state.user.value!.riskClass.toUpperCase(),
                    ),
                    AppGaps.h30,
                    MetricsContainer(
                      height: controller.state.user.value!.heightCm,
                      age: controller.state.user.value!.age,
                      gender: controller.state.user.value!.gender,
                      weight: controller.state.user.value!.weightKg,
                    ),
                    AppGaps.h30,
                  ],
                ),
        ),
      ),
    );
  }
}
