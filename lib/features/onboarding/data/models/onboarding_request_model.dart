import 'package:manifesto/features/onboarding/domain/entities/onboarding_request_entity.dart';

class OnboardingRequestModel extends OnboardingRequestEntity {
  OnboardingRequestModel({
    required super.age,
    required super.height,
    required super.weight,
    required super.systolic,
    required super.diastolic,
    required super.gender,
    required super.cholesterol,
    required super.glucose,
    required super.smokes,
    required super.drinksAlcohol,
    required super.physicallyActive,
  });

  factory OnboardingRequestModel.fromEntity(OnboardingRequestEntity entity) {
    return OnboardingRequestModel(
      age: entity.age,
      height: entity.height,
      weight: entity.weight,
      systolic: entity.systolic,
      diastolic: entity.diastolic,
      gender: entity.gender,
      cholesterol: entity.cholesterol,
      glucose: entity.glucose,
      smokes: entity.smokes,
      drinksAlcohol: entity.drinksAlcohol,
      physicallyActive: entity.physicallyActive,
    );
  }

  factory OnboardingRequestModel.fromJson(Map<String, dynamic> json) {
    return OnboardingRequestModel(
      age: (json['age'] as num?)?.toInt() ?? 0,
      height: (json['height_cm'] as num?)?.toDouble() ?? 0.0,
      weight: (json['weight_kg'] as num?)?.toDouble() ?? 0.0,
      systolic: (json['blood_pressure_systolic'] as num?)?.toDouble() ?? 0.0,
      diastolic: (json['blood_pressure_diastolic'] as num?)?.toDouble() ?? 0.0,
      gender: json['gender'] as String? ?? '',
      cholesterol: (json['cholesterol_mg_dl'] as num?)?.toDouble() ?? 0.0,
      glucose: (json['glucose_mg_dl'] as num?)?.toDouble() ?? 0.0,
      smokes: json['smokes'] as bool? ?? false,
      drinksAlcohol: json['drinks_alcohol'] as bool? ?? false,
      physicallyActive: json['physically_active'] as bool? ?? false,
    );
  }

  OnboardingRequestEntity toEntity() {
    return OnboardingRequestEntity(
      age: age,
      height: height,
      weight: weight,
      systolic: systolic,
      diastolic: diastolic,
      gender: gender,
      cholesterol: cholesterol,
      glucose: glucose,
      smokes: smokes,
      drinksAlcohol: drinksAlcohol,
      physicallyActive: physicallyActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'height_cm': height,
      'weight_kg': weight,
      'blood_pressure_systolic': systolic,
      'blood_pressure_diastolic': diastolic,
      'gender': gender,
      'cholesterol_mg_dl': cholesterol,
      'glucose_mg_dl': glucose,
      'smokes': smokes,
      'drinks_alcohol': drinksAlcohol,
      'physically_active': physicallyActive,
    };
  }
}
