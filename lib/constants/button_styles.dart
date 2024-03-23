import 'package:flutter/material.dart';

import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';

class ButtonStyles {
  static ButtonStyle buttonPrimary = ButtonStyle(
      textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyles.body),
      foregroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.buttonLabelPrimary),
      backgroundColor: const MaterialStatePropertyAll<Color>(
          AppColors.buttonBackgroundPrimary),
      fixedSize: const MaterialStatePropertyAll<Size?>(Size.fromHeight(56)),
      shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(17.0)),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0))));

  static ButtonStyle buttonSecondary = ButtonStyle(
      textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyles.body),
      foregroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.buttonLabelSecondary),
      backgroundColor: const MaterialStatePropertyAll<Color>(
          AppColors.buttonBackgroundSecondary),
      fixedSize: const MaterialStatePropertyAll<Size?>(Size.fromHeight(56)),
      shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(17.0)),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0))));

  static ButtonStyle buttonCard = ButtonStyle(
      elevation: const MaterialStatePropertyAll<double>(2),
      surfaceTintColor:
          const MaterialStatePropertyAll<Color>(AppColors.backgroundElevated),
      backgroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.backgroundElevated),
      shadowColor:
          MaterialStatePropertyAll<Color>(Colors.black.withOpacity(0.25)),
      padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(0)),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0))));
}
