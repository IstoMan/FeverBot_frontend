import 'package:get/get.dart';
import 'package:manifesto/common/widgets/toast_message.dart';
import 'package:manifesto/features/onboarding/domain/entities/onboarding_request_entity.dart';
import 'package:manifesto/features/onboarding/domain/usecases/onboarding_usecase.dart';
import 'package:manifesto/features/onboarding/presentation/states/onboarding_state.dart';
import 'package:manifesto/routes/app_routes.dart';
import 'package:toastification/toastification.dart';

class OnboardingController extends GetxController {
  final OnboardingState state;
  final GetOnboardingUseCase getOnboardingUseCase;

  OnboardingController({
    required this.getOnboardingUseCase,
    required this.state,
  });

  @override
  void onClose() {
    state.heightController.dispose();
    state.weightController.dispose();
    state.systolicController.dispose();
    state.diastolicController.dispose();
    state.cholesterolController.dispose();
    state.glucoseController.dispose();
    state.ageController.dispose();
    super.onClose();
  }

  Future<void> completeProfile() async {
    final result = await getOnboardingUseCase.call(
      GetOnboardingDataUseCaseParams(
        request: OnboardingRequestEntity(
          age: int.tryParse(state.ageController.text) ?? 0,
          height: double.tryParse(state.heightController.text) ?? 0.0,
          weight: double.tryParse(state.weightController.text) ?? 0.0,
          systolic: double.tryParse(state.systolicController.text) ?? 0.0,
          diastolic: double.tryParse(state.diastolicController.text) ?? 0.0,
          gender: state.selectedGender.value.toLowerCase(),
          cholesterol: double.tryParse(state.cholesterolController.text) ?? 0.0,
          glucose: double.tryParse(state.glucoseController.text) ?? 0.0,
          smokes: state.smokeYes.value,
          drinksAlcohol: state.alcoholYes.value,
          physicallyActive: state.activeYes.value,
        ),
      ),
    );
    result.fold((error) {
      showToastNotification(
        title: "Error",
        body: error.toString(),
        messageType: ToastificationType.error,
      );
    }, (data) {
      Get.offAllNamed(AppRoutes.dashboard);
    });
  }
}
