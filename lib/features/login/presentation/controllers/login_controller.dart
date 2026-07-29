import 'package:get/get.dart';
import 'package:manifesto/common/widgets/toast_message.dart';
import 'package:manifesto/features/dashboard/domain/usecases/get_user_usecase.dart';
import 'package:manifesto/features/login/domain/entities/login_request_entity.dart';
import 'package:manifesto/features/login/domain/usecases/login_usecase.dart';
import 'package:manifesto/features/login/presentation/states/login_state.dart';
import 'package:manifesto/routes/app_routes.dart';
import 'package:toastification/toastification.dart';

class LoginController extends GetxController {
  final LoginState state;
  final GetLoginUseCase getLoginUseCase;
  final GetUserUseCase getUserUseCase;

  LoginController({
    required this.getLoginUseCase,
    required this.getUserUseCase,
    required this.state,
  });

  @override
  void onClose() {
    state.emailController.dispose();
    state.passwordController.dispose();
    super.onClose();
  }

  Future<void> fetchLoginData() async {
    state.isLoading.value = true;
    final result = await getLoginUseCase.call(
      GetLoginDataUseCaseParams(
        request: LoginRequestEntity(
          password: state.passwordController.text,
          email: state.emailController.text,
        ),
      ),
    );

    if (result.isLeft()) {
      showToastNotification(
        title: "Error",
        body: result.fold((error) => error.toString(), (_) => ''),
        messageType: ToastificationType.error,
      );
      state.isLoading.value = false;
      return;
    }

    final userResult = await getUserUseCase.call();
    userResult.fold(
      (error) {
        showToastNotification(
          title: "Error",
          body: error.toString(),
          messageType: ToastificationType.error,
        );
        Get.offAllNamed(AppRoutes.dashboard);
      },
      (user) {
        Get.offAllNamed(
          user.onboardingComplete
              ? AppRoutes.dashboard
              : AppRoutes.onboarding,
        );
      },
    );
    state.isLoading.value = false;
  }
}
