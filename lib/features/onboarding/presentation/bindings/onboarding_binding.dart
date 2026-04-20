import 'package:get/get.dart';
import 'package:manifesto/features/onboarding/data/datasources/local/onboarding_local_datasource.dart';
import 'package:manifesto/features/onboarding/data/datasources/remote/onboarding_remote_datasource.dart';
import 'package:manifesto/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:manifesto/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:manifesto/features/onboarding/domain/usecases/onboarding_usecase.dart';
import 'package:manifesto/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:manifesto/features/onboarding/presentation/states/onboarding_state.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingRemoteDataSource>(
      () => OnboardingRemoteDataSourceImpl(Get.find()),
    );
    Get.lazyPut<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(),
    );
    Get.lazyPut<OnboardingRepository>(
      () => OnboardingRepositoryImpl(
        remoteDataSource: Get.find(),
        localDataSource: Get.find(),
      ),
    );
    Get.lazyPut<GetOnboardingUseCase>(
      () => GetOnboardingUseCase(Get.find()),
    );
    Get.lazyPut<OnboardingState>(() => OnboardingState());
    Get.lazyPut<OnboardingController>(() => OnboardingController(
        getOnboardingUseCase: Get.find<GetOnboardingUseCase>(),
        state: Get.find<OnboardingState>()));
  }
}
