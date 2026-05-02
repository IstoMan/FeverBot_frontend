class OnboardingEntity {
  final String uid;
  final String displayName;
  final int age;
  final double heightCm;
  final double weightKg;
  final String gender;
  final int cholesterol;
  final int glucOrdinal;
  final bool smokes;
  final bool drinksAlcohol;
  final bool physicallyActive;
  final int bloodPressureSystolic;
  final int bloodPressureDiastolic;
  final double bmi;
  final double riskScore;
  final String riskClass;
  final bool onboardingComplete;
  final DateTime updatedAt;

  OnboardingEntity({
    required this.uid,
    required this.displayName,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.gender,
    required this.cholesterol,
    required this.glucOrdinal,
    required this.smokes,
    required this.drinksAlcohol,
    required this.physicallyActive,
    required this.bloodPressureSystolic,
    required this.bloodPressureDiastolic,
    required this.bmi,
    required this.riskScore,
    required this.riskClass,
    required this.onboardingComplete,
    required this.updatedAt,
  });
}
