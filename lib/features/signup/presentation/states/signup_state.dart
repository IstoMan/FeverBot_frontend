import 'package:get/get.dart';
import 'package:manifesto/features/signup/domain/entities/signup_entity.dart';

class SignupState extends GetXState {
  RxBool isLoading = false.obs;
  final signupData = Rxn<SignupEntity>();
}
