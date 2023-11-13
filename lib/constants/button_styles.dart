import 'package:flutter/material.dart';

import 'package:app_template/constants/colors.dart';
import 'package:app_template/constants/text_styles.dart';

class ButtonStyles {
  static ButtonStyle buttonDefault = ButtonStyle(
      textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyles.body),
      foregroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.labelPrimary),
      backgroundColor:
          const MaterialStatePropertyAll<Color>(AppColors.background),
      fixedSize: const MaterialStatePropertyAll<Size?>(Size.fromHeight(48)),
      shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(12.0)),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0))));
}
