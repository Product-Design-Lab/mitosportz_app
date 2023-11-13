import 'package:flutter/material.dart';

import 'package:app_template/constants/colors.dart';

class TextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.labelPrimary,
    letterSpacing: -1,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
  );

  static const TextStyle body = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.4,
      height: 1.29);
}
