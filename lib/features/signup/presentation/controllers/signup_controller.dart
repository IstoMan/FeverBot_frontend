import 'package:get/get.dart';
import 'package:manifesto/common/widgets/toast_message.dart';
import 'package:manifesto/features/signup/domain/entities/signup_request_entity.dart';
import 'package:manifesto/features/signup/domain/usecases/signup_usecase.dart';
import 'package:manifesto/features/signup/presentation/states/signup_state.dart';
import 'package:manifesto/routes/app_routes.dart';
import 'package:toastification/toastification.dart';

class SignupController extends GetxController {
  final SignupState state;
  final GetSignupUseCase getSignupUseCase;

  SignupController({required this.getSignupUseCase, required this.state});

  Future<void> signup() async {
    final result = await getSignupUseCase(
      GetSignupDataUseCaseParams(
        request: SignupRequestEntity(
          name: state.nameController.text,
          email: state.emailController.text,
          password: state.passwordController.text,
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
      Get.offAllNamed(AppRoutes.onboarding);
    });
  }
}
