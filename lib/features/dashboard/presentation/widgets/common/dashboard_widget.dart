import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Dashboard Widget',
      style: Theme.of(context).textTheme.displayLarge,
    ));
  }
}
