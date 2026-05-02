import 'package:manifesto/features/login/domain/entities/login_request_entity.dart';

class LoginRequestModel extends LoginRequestEntity {
  LoginRequestModel({
    required super.password,
    required super.email,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  LoginRequestEntity toEntity() {
    return LoginRequestEntity(
      email: email,
      password: password,
    );
  }

  factory LoginRequestModel.fromEntity(LoginRequestEntity entity) {
    return LoginRequestModel(
      email: entity.email,
      password: entity.password,
    );
  }
}
