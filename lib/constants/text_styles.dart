import 'package:flutter/material.dart';

import 'package:mitosportz/constants/colors.dart';

class TextStyles {
  static const TextStyle largeTitle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w500,
    color: AppColors.labelPrimary,
    letterSpacing: -1,
    height: 1.2,
  );

  static const TextStyle title = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: AppColors.labelPrimary,
    letterSpacing: -1,
    height: 1.2,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
    height: 1.18,
  );

  static const TextStyle body = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.4,
    height: 1.29,
  );

  static const TextStyle smallBody = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.4,
    height: 1.4,
  );
}
