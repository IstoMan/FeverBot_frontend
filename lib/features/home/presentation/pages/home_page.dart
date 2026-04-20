import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifesto/common/resources/app_resources/app_strings.dart';
import 'package:manifesto/features/home/presentation/controllers/home_controller.dart';
import 'package:manifesto/features/home/presentation/widgets/home_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(AppStrings.appBarText),
          ),
        ),
        body: Obx(() {
          if (controller.state.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return const HomeWidget();
        }),
      ),
    );
  }
}
