import 'package:flutter/material.dart';

import 'package:mitosportz/constants/colors.dart';

class ProgressWidget extends StatelessWidget {
  final Color color;
  final double progress;

  const ProgressWidget(
      {super.key, required this.color, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      decoration: BoxDecoration(
          color: AppColors.background, borderRadius: BorderRadius.circular(12)),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
