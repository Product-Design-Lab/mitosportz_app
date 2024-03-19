import 'package:flutter/material.dart';

import 'package:mitosportz/widgets/base.dart';
import 'package:mitosportz/widgets/text_input_widget.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String? error;

  @override
  void initState() {
    super.initState();
  }

  void action(String value) {
    setState(() {
      error = _validator(value);
    });
    if (error == null) {
      print(value);
    }
  }

  bool _isNumeric(String value) {
    return num.tryParse(value) != null;
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a 4 digit code";
    }
    if (value.length != 4) {
      return "Please enter a 4 digit code";
    }
    if (!_isNumeric(value)) {
      return "Please enter digits";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: TextInputWidget(
      title: "Enter Pairing Code",
      subtitle: "Use your 4-digit device code to connect",
      hintText: "1234",
      action: action,
      actionText: "Connect",
      errorText: error,
      keyboardType: TextInputType.number,
    ));
  }
}
