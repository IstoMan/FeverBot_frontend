import 'package:manifesto/features/login/domain/entities/login_entity.dart';

/// This is an example model class extending example model entity
class LoginModel extends LoginEntity {
  LoginModel({
    required super.id,
    required super.name,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  LoginEntity toEntity() {
    return LoginEntity(
      id: id,
      name: name,
    );
  }

  factory LoginModel.fromEntity(LoginEntity entity) {
    return LoginModel(
      id: entity.id,
      name: entity.name,
    );
  }
}
