import 'package:get/get.dart';
import 'package:manifesto/features/onboarding/domain/usecases/onboarding_usecase.dart';
import 'package:manifesto/features/onboarding/presentation/states/onboarding_state.dart';

class OnboardingController extends GetxController {
  final OnboardingState state;
  final GetOnboardingUseCase getOnboardingUseCase;

  OnboardingController(
      {required this.getOnboardingUseCase, required this.state});

}
