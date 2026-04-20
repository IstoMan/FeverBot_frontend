import 'package:get/get.dart';
import 'package:manifesto/features/signup/data/datasources/local/signup_local_datasource.dart';
import 'package:manifesto/features/signup/data/datasources/remote/signup_remote_datasource.dart';
import 'package:manifesto/features/signup/data/repositories/signup_repository_impl.dart';
import 'package:manifesto/features/signup/domain/repositories/signup_repository.dart';
import 'package:manifesto/features/signup/domain/usecases/signup_usecase.dart';
import 'package:manifesto/features/signup/presentation/controllers/signup_controller.dart';
import 'package:manifesto/features/signup/presentation/states/signup_state.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupRemoteDataSource>(
      () => SignupRemoteDataSourceImpl(Get.find()),
    );
    Get.lazyPut<SignupLocalDataSource>(
      () => SignupLocalDataSourceImpl(),
    );
    Get.lazyPut<SignupRepository>(
      () => SignupRepositoryImpl(
        remoteDataSource: Get.find(),
        localDataSource: Get.find(),
      ),
    );
    Get.lazyPut<GetSignupUseCase>(
      () => GetSignupUseCase(Get.find()),
    );
    Get.lazyPut<SignupState>(() => SignupState());
    Get.lazyPut<SignupController>(() => SignupController(
        getSignupUseCase: Get.find<GetSignupUseCase>(),
        state: Get.find<SignupState>()));
  }
}
