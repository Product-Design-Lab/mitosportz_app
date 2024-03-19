import 'package:flutter/material.dart';

import 'package:mitosportz/widgets/base.dart';
import 'package:mitosportz/widgets/text_input_widget.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  void action(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: TextInputWidget(
            title: "Enter Pairing Code",
            subtitle: "Use your 4-digit device code to connect",
            hintText: "1234",
            action: action,
            actionText: "Connect"));
  }
}
