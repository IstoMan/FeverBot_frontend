import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manifesto/features/login/domain/entities/login_request_entity.dart';

class LoginState extends GetXState {
  RxBool isLoading = false.obs;
  final loginData = Rxn<LoginRequestEntity>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}
