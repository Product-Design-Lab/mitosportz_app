import 'package:flutter/material.dart';

import 'colors.dart';

class WidgetStyles {
  static const double radiusSmall = 16.0;
  static const double radiusLarge = 32.0;

  static ThemeData baseTheme = ThemeData(
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.labelPrimary,
          onPrimary: AppColors.buttonLabelPrimary,
          secondary: AppColors.labelSecondary,
          onSecondary: AppColors.buttonLabelPrimary,
          error: AppColors.red,
          onError: AppColors.buttonLabelPrimary,
          background: AppColors.background,
          onBackground: AppColors.labelPrimary,
          surface: AppColors.backgroundElevated,
          onSurface: AppColors.labelPrimary),
      primaryColor: AppColors.labelPrimary,
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.labelPrimary,
          selectionColor: AppColors.background,
          selectionHandleColor: AppColors.buttonLabelPrimary));

  static BoxDecoration elevatedCard = const BoxDecoration(
      color: AppColors.backgroundElevated,
      borderRadius: BorderRadius.all(Radius.circular(radiusLarge)));
}
