import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Onboarding Widget',
      style: Theme.of(context).textTheme.displayLarge,
    ));
  }
}
