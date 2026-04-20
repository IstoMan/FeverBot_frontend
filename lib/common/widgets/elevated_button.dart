import 'package:flutter/material.dart';
import 'package:manifesto/common/widgets/shadow_container.dart';

class RElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const RElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RShadowContainer(
      enableBorder: false,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFAF2900),
              Color(0xFFD63C10),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          label: const Icon(Icons.arrow_forward),
          icon: Text(label),
        ),
      ),
    );
  }
}
