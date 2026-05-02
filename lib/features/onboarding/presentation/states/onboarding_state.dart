import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manifesto/features/onboarding/domain/entities/onboarding_entity.dart';

class OnboardingState extends GetXState {
  RxBool isLoading = false.obs;
  final onboardingData = Rxn<OnboardingEntity>();
  RxString selectedGender = "MALE".obs;
  RxBool smokeYes = false.obs;
  RxBool alcoholYes = false.obs;
  RxBool activeYes = false.obs;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController systolicController = TextEditingController();
  TextEditingController diastolicController = TextEditingController();
  TextEditingController cholesterolController = TextEditingController();
  TextEditingController glucoseController = TextEditingController();
  TextEditingController ageController = TextEditingController();
}
