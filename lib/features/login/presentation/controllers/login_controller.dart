import 'package:get/get.dart';
import 'package:manifesto/features/login/domain/usecases/login_usecase.dart';
import 'package:manifesto/features/login/presentation/states/login_state.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';
import 'package:toastification/toastification.dart';
import 'package:manifesto/common/widgets/toast_message.dart';
import 'package:manifesto/features/login/domain/entities/login_request_entity.dart';

class LoginController extends GetxController {
  final LoginState state;
  final GetLoginUseCase getLoginUseCase;

  LoginController({required this.getLoginUseCase, required this.state});

  Future<void> fetchLoginData() async {
    try {
      state.isLoading.toggle();

      final request = LoginRequestEntity(
        id: "1",
      );

      final result =
          await getLoginUseCase(GetLoginDataUseCaseParams(request: request));

      result.fold(
        (failure) {
          Log.error(failure, ["error while fetching LoginData"]);
          showToastNotification(
            title: 'Could not fetch details',
            body: 'Please try again later',
            messageType: ToastificationType.error,
          );

          state.isLoading.toggle();
        },
        (data) => state.loginData.value = data,
      );
    } catch (e, stackTrace) {
      Log.error(
          "Unexpected error during fetching of login data", e, stackTrace);
      showToastNotification(
        title: 'Failed Fetching LoginData',
        body: 'An unexpected error occurred. Please try again.',
        messageType: ToastificationType.error,
      );
      state.isLoading.value = false;
    }
  }
}
