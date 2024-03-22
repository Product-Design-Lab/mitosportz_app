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

  static BoxDecoration elevatedCard = BoxDecoration(
      color: AppColors.backgroundElevated,
      boxShadow: [WidgetStyles.elevated],
      borderRadius: const BorderRadius.all(Radius.circular(radiusLarge)));

  static BoxShadow elevated = BoxShadow(
      color: Colors.black.withOpacity(0.075),
      blurRadius: 2,
      offset: const Offset(0, 2));
}
