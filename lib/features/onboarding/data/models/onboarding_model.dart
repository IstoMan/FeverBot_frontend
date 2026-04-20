import 'package:manifesto/features/onboarding/domain/entities/onboarding_entity.dart';

/// This is an example model class extending example model entity
class OnboardingModel extends OnboardingEntity {
  OnboardingModel({
    required super.id,
    required super.name,
  });

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
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

  OnboardingEntity toEntity() {
    return OnboardingEntity(
      id: id,
      name: name,
    );
  }

  factory OnboardingModel.fromEntity(OnboardingEntity entity) {
    return OnboardingModel(
      id: entity.id,
      name: entity.name,
    );
  }
}
