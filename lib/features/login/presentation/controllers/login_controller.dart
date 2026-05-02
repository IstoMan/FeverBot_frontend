import 'package:get/get.dart';
import 'package:manifesto/common/widgets/toast_message.dart';
import 'package:manifesto/features/login/domain/entities/login_request_entity.dart';
import 'package:manifesto/features/login/domain/usecases/login_usecase.dart';
import 'package:manifesto/features/login/presentation/states/login_state.dart';
import 'package:manifesto/routes/app_routes.dart';
import 'package:toastification/toastification.dart';

class LoginController extends GetxController {
  final LoginState state;
  final GetLoginUseCase getLoginUseCase;

  LoginController({required this.getLoginUseCase, required this.state});

  Future<void> fetchLoginData() async {
    final result = await getLoginUseCase.call(
      GetLoginDataUseCaseParams(
        request: LoginRequestEntity(
          password: state.passwordController.text,
          email: state.emailController.text,
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
