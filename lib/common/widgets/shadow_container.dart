import 'package:flutter/cupertino.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';

class RShadowContainer extends StatelessWidget {
  final Widget? child;
  final bool enableShadow;
  final bool enableBorder;

  const RShadowContainer({
    super.key,
    this.child,
    this.enableShadow = true,
    this.enableBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: enableShadow
            ? [
                const BoxShadow(
                  color: Color(0xFF000000),
                  blurRadius: 0,
                  spreadRadius: 0,
                  offset: Offset(4, 4),
                ),
              ]
            : [],
      ),
      foregroundDecoration: BoxDecoration(
        border: enableBorder
            ? Border.all(
                color: AppColors.black,
                width: AppSizes.v1,
              )
            : null,
      ),
      child: child,
    );
  }
}
