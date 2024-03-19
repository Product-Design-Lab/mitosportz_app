import 'package:flutter/material.dart';

import 'colors.dart';

class WidgetStyles {
  static const double radiusSmall = 16.0;
  static const double radiusLarge = 32.0;

  static ThemeData baseTheme = ThemeData(
      primaryColor: AppColors.labelPrimary,
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.labelPrimary,
          selectionColor: AppColors.background,
          selectionHandleColor: AppColors.buttonLabelPrimary));

  static BoxDecoration elevatedCard = const BoxDecoration(
      color: AppColors.backgroundElevated,
      borderRadius: BorderRadius.all(Radius.circular(radiusLarge)));
}
