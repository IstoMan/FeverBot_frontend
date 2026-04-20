import 'package:flutter/material.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Signup Widget',
      style: Theme.of(context).textTheme.displayLarge,
    ));
  }
}
