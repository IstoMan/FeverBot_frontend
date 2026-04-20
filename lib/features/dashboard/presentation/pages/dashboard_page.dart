import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifesto/common/resources/app_resources/app_strings.dart';
import 'package:manifesto/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/common/custom_navigation_bar.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/tabs/chatbot_tab.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/tabs/dashboard_tab.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/tabs/profile_tab.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const DashboardTab(),
      const ChatbotTab(),
      const ProfileTab(),
      const ProfileTab(),
    ];
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appBarText),
        ),
        body: IndexedStack(
          index: controller.state.currentIndex.value,
          children: tabs,
        ),
        bottomNavigationBar: RNavigationBar(buttons: [
          RNavigationButtons(
            onTap: () => controller.state.currentIndex.value = 0,
            icon: Icons.home,
            label: "DASHBOARD",
            isActive: controller.state.currentIndex.value == 0,
          ),
          RNavigationButtons(
            onTap: () => controller.state.currentIndex.value = 1,
            icon: Icons.chat,
            label: "CHATBOT",
            isActive: controller.state.currentIndex.value == 1,
          ),
          RNavigationButtons(
            onTap: () => controller.state.currentIndex.value = 2,
            icon: Icons.person,
            label: "PROFILE",
            isActive: controller.state.currentIndex.value == 2,
          ),
          RNavigationButtons(
            onTap: () => controller.state.currentIndex.value = 3,
            icon: Icons.person,
            label: "PROFILE",
            isActive: controller.state.currentIndex.value == 3,
          ),
        ]),
      ),
    );
  }
}
