import 'package:flutter/material.dart';
import 'package:mitosportz/constants/button_styles.dart';
import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';
import 'package:mitosportz/widgets/base.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  void action() {}

  @override
  Widget build(BuildContext context) {
    return Base(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: AppColors.backgroundElevated,
                borderRadius: BorderRadius.all(Radius.circular(32))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Enter Pairing Code",
                  style: TextStyles.title,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 48, bottom: 48),
                  child: TextFormField(
                    style: TextStyles.largeTitle,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "1234",
                        hintStyle: TextStyles.largeTitle
                            .copyWith(color: AppColors.labelTertiary)),
                  ),
                ),
                const Text(
                  "Connect your device",
                  style: TextStyles.body,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ElevatedButton(
              onPressed: action,
              style: ButtonStyles.buttonPrimary,
              child: const Text("Submit")),
        )
      ],
    ));
  }
}
