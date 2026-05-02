import 'package:manifesto/features/signup/domain/entities/signup_entity.dart';

class SignupModel extends SignupEntity {
  SignupModel({
    required super.token,
  });

  factory SignupModel.fromEntity(SignupEntity entity) {
    return SignupModel(
      token: entity.token,
    );
  }

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      token: json['access_token'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': token,
    };
  }

}
