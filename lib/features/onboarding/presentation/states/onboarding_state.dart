import 'package:get/get.dart';
import 'package:manifesto/features/onboarding/domain/entities/onboarding_entity.dart';

class OnboardingState extends GetXState {
  RxBool isLoading = false.obs;
  final onboardingData = Rxn<OnboardingEntity>();
  RxString selectedGender = "MALE".obs;
  RxBool smokeYes = false.obs;
  RxBool alcoholYes = false.obs;
  RxBool activeYes = false.obs;
}
