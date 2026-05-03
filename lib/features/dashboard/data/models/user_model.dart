import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      displayName: json['display_name'] as String,
      age: (json['age'] as num).toInt(),
      heightCm: (json['height_cm'] as num).toDouble(),
      weightKg: (json['weight_kg'] as num).toDouble(),
      gender: json['gender'] as String,
      cholesterol: (json['cholesterol'] as num).toInt(),
      glucOrdinal: (json['gluc_ordinal'] as num).toInt(),
      smokes: json['smokes'] as bool,
      drinksAlcohol: json['drinks_alcohol'] as bool,
      physicallyActive: json['physically_active'] as bool,
      bloodPressureSystolic: (json['blood_pressure_systolic'] as num).toInt(),
      bloodPressureDiastolic: (json['blood_pressure_diastolic'] as num).toInt(),
      bmi: (json['bmi'] as num).toDouble(),
      riskScore: (json['risk_score'] as num).toDouble(),
      riskClass: json['risk_class'] as String,
      onboardingComplete: json['onboarding_complete'] as bool,
      updatedAt: json['updated_at'] as String,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
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
      'updated_at': updatedAt,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
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
}
