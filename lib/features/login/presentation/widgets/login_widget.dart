import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Login Widget',
      style: Theme.of(context).textTheme.displayLarge,
    ));
  }
}
