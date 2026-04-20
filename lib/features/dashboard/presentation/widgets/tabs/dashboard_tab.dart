import 'package:flutter/material.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';

import '../dashboard/dial_container.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.w15),
      child: Column(
        children: [
          AppGaps.h50,
          DialContainer(),
        ],
      ),
    );
  }
}
