import 'package:manifesto/features/signup/domain/entities/signup_request_entity.dart';

class SignupRequestModel extends SignupRequestEntity {
  SignupRequestModel({
    required super.name,
    required super.email,
    required super.password,
  });

  factory SignupRequestModel.fromEntity(SignupRequestEntity entity) {
    return SignupRequestModel(
      name: entity.name,
      email: entity.email,
      password: entity.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  SignupRequestEntity toEntity() {
    return SignupRequestEntity(
      name: name,
      email: email,
      password: password,
    );
  }
}
