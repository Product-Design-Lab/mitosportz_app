import 'package:flutter/material.dart';

import 'package:mitosportz/constants/colors.dart';

class SequenceWidget extends StatelessWidget {
  final Color color;
  final List<bool> sequence;

  const SequenceWidget(
      {super.key, required this.color, required this.sequence});

  Widget _bar(bool active) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        height: 12,
        decoration: BoxDecoration(
            color: active ? color : AppColors.background,
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: sequence.map((isActive) => _bar(isActive)).toList(),
    );
  }
}
