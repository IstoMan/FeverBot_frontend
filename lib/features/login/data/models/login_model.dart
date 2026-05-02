import 'package:manifesto/features/login/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    required super.token,
  });

  factory LoginModel.fromEntity(LoginEntity entity) {
    return LoginModel(
      token: entity.token,
    );
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['access_token'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': token,
    };
  }

  LoginEntity toEntity() {
    return LoginEntity(
      token: token,
    );
  }
}
