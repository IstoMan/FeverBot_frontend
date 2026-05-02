class OnboardingRequestEntity {
  final int age;
  final double height;
  final double weight;
  final double systolic;
  final double diastolic;
  final String gender;
  final double cholesterol;
  final double glucose;
  final bool smokes;
  final bool drinksAlcohol;
  final bool physicallyActive;

  OnboardingRequestEntity({
    required this.age,
    required this.height,
    required this.weight,
    required this.systolic,
    required this.diastolic,
    required this.gender,
    required this.cholesterol,
    required this.glucose,
    required this.smokes,
    required this.drinksAlcohol,
    required this.physicallyActive,
  });
}
