import 'package:get/get.dart';
import 'package:manifesto/features/login/domain/entities/login_entity.dart';

class LoginState extends GetXState {
  RxBool isLoading = false.obs;
  final loginData = Rxn<LoginEntity>();
}
