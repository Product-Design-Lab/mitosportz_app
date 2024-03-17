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
      backgroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.buttonLabelSecondary),
      fixedSize: const MaterialStatePropertyAll<Size?>(Size.fromHeight(56)),
      shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(17.0)),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0))));
}
