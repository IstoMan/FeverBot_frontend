import 'package:manifesto/features/onboarding/domain/entities/onboarding_entity.dart';

class OnboardingModel extends OnboardingEntity {
  OnboardingModel({
    required super.uid,
    required super.displayName,
    required super.age,
    required super.heightCm,
    required super.weightKg,
    required super.gender,
    required super.cholesterol,
    required super.glucOrdinal,
    required super.smokes,
    required super.drinksAlcohol,
    required super.physicallyActive,
    required super.bloodPressureSystolic,
    required super.bloodPressureDiastolic,
    required super.bmi,
    required super.riskScore,
    required super.riskClass,
    required super.onboardingComplete,
    required super.updatedAt,
  });

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      uid: json['uid'] as String? ?? '',
      displayName: json['display_name'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      heightCm: (json['height_cm'] as num?)?.toDouble() ?? 0.0,
      weightKg: (json['weight_kg'] as num?)?.toDouble() ?? 0.0,
      gender: json['gender'] as String? ?? '',
      cholesterol: json['cholesterol'] as int? ?? 0,
      glucOrdinal: json['gluc_ordinal'] as int? ?? 0,
      smokes: json['smokes'] as bool? ?? false,
      drinksAlcohol: json['drinks_alcohol'] as bool? ?? false,
      physicallyActive: json['physically_active'] as bool? ?? false,
      bloodPressureSystolic: json['blood_pressure_systolic'] as int? ?? 0,
      bloodPressureDiastolic: json['blood_pressure_diastolic'] as int? ?? 0,
      bmi: (json['bmi'] as num?)?.toDouble() ?? 0.0,
      riskScore: (json['risk_score'] as num?)?.toDouble() ?? 0.0,
      riskClass: json['risk_class'] as String? ?? 'low',
      onboardingComplete: json['onboarding_complete'] as bool? ?? false,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
    );
  }

  factory OnboardingModel.fromEntity(OnboardingEntity entity) {
    return OnboardingModel(
      uid: entity.uid,
      displayName: entity.displayName,
      age: entity.age,
      heightCm: entity.heightCm,
      weightKg: entity.weightKg,
      gender: entity.gender,
      cholesterol: entity.cholesterol,
      glucOrdinal: entity.glucOrdinal,
      smokes: entity.smokes,
      drinksAlcohol: entity.drinksAlcohol,
      physicallyActive: entity.physicallyActive,
      bloodPressureSystolic: entity.bloodPressureSystolic,
      bloodPressureDiastolic: entity.bloodPressureDiastolic,
      bmi: entity.bmi,
      riskScore: entity.riskScore,
      riskClass: entity.riskClass,
      onboardingComplete: entity.onboardingComplete,
      updatedAt: entity.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'display_name': displayName,
      'age': age,
      'height_cm': heightCm,
      'weight_kg': weightKg,
      'gender': gender,
      'cholesterol': cholesterol,
      'gluc_ordinal': glucOrdinal,
      'smokes': smokes,
      'drinks_alcohol': drinksAlcohol,
      'physically_active': physicallyActive,
      'blood_pressure_systolic': bloodPressureSystolic,
      'blood_pressure_diastolic': bloodPressureDiastolic,
      'bmi': bmi,
      'risk_score': riskScore,
      'risk_class': riskClass,
      'onboarding_complete': onboardingComplete,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  OnboardingEntity toEntity() {
    return OnboardingEntity(
      uid: uid,
      displayName: displayName,
      age: age,
      heightCm: heightCm,
      weightKg: weightKg,
      gender: gender,
      cholesterol: cholesterol,
      glucOrdinal: glucOrdinal,
      smokes: smokes,
      drinksAlcohol: drinksAlcohol,
      physicallyActive: physicallyActive,
      bloodPressureSystolic: bloodPressureSystolic,
      bloodPressureDiastolic: bloodPressureDiastolic,
      bmi: bmi,
      riskScore: riskScore,
      riskClass: riskClass,
      onboardingComplete: onboardingComplete,
      updatedAt: updatedAt,
    );
  }

  OnboardingModel copyWith({
    String? uid,
    String? displayName,
    int? age,
    double? heightCm,
    double? weightKg,
    String? gender,
    int? cholesterol,
    int? glucOrdinal,
    bool? smokes,
    bool? drinksAlcohol,
    bool? physicallyActive,
    int? bloodPressureSystolic,
    int? bloodPressureDiastolic,
    double? bmi,
    double? riskScore,
    String? riskClass,
    bool? onboardingComplete,
    DateTime? updatedAt,
  }) {
    return OnboardingModel(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      gender: gender ?? this.gender,
      cholesterol: cholesterol ?? this.cholesterol,
      glucOrdinal: glucOrdinal ?? this.glucOrdinal,
      smokes: smokes ?? this.smokes,
      drinksAlcohol: drinksAlcohol ?? this.drinksAlcohol,
      physicallyActive: physicallyActive ?? this.physicallyActive,
      bloodPressureSystolic:
          bloodPressureSystolic ?? this.bloodPressureSystolic,
      bloodPressureDiastolic:
          bloodPressureDiastolic ?? this.bloodPressureDiastolic,
      bmi: bmi ?? this.bmi,
      riskScore: riskScore ?? this.riskScore,
      riskClass: riskClass ?? this.riskClass,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
