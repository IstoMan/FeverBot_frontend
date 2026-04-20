import 'package:get/get.dart';
import 'package:manifesto/features/signup/domain/usecases/signup_usecase.dart';
import 'package:manifesto/features/signup/presentation/states/signup_state.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';
import 'package:toastification/toastification.dart';
import 'package:manifesto/common/widgets/toast_message.dart';
import 'package:manifesto/features/signup/domain/entities/signup_request_entity.dart';

class SignupController extends GetxController {
  final SignupState state;
  final GetSignupUseCase getSignupUseCase;

  SignupController({required this.getSignupUseCase, required this.state});

  @override
  void onInit() {
    super.onInit();
    fetchSignupData();
  }

  Future<void> fetchSignupData() async {
    try {
      state.isLoading.toggle();

      final request = SignupRequestEntity(
        id: "1",
      );

      final result =
          await getSignupUseCase(GetSignupDataUseCaseParams(request: request));

      result.fold(
        (failure) {
          Log.error(failure, ["error while fetching SignupData"]);
          showToastNotification(
            title: 'Could not fetch details',
            body: 'Please try again later',
            messageType: ToastificationType.error,
          );

          state.isLoading.toggle();
        },
        (data) => state.signupData.value = data,
      );
    } catch (e, stackTrace) {
      Log.error(
          "Unexpected error during fetching of signup data", e, stackTrace);
      showToastNotification(
        title: 'Failed Fetching SignupData',
        body: 'An unexpected error occurred. Please try again.',
        messageType: ToastificationType.error,
      );
      state.isLoading.value = false;
    }
  }
}
