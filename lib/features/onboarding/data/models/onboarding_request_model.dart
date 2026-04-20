import 'package:manifesto/features/onboarding/domain/entities/onboarding_request_entity.dart';

class OnboardingRequestModel extends OnboardingRequestEntity {
  OnboardingRequestModel({
    required super.id,
  });

  factory OnboardingRequestModel.fromEntity(OnboardingRequestEntity entity) {
    return OnboardingRequestModel(
      id: entity.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  OnboardingRequestEntity toEntity() {
    return OnboardingRequestEntity(
      id: id,
    );
  }
}
