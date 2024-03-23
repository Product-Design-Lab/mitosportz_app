import 'package:flutter/material.dart';
import 'package:mitosportz/widgets/base.dart';

import 'package:mitosportz/widgets/text_input_widget.dart';

class EditDurationScreen extends StatefulWidget {
  const EditDurationScreen({Key? key}) : super(key: key);

  @override
  State<EditDurationScreen> createState() => _EditDurationScreenState();
}

class _EditDurationScreenState extends State<EditDurationScreen> {
  void _action(String value) {
    _exit();
  }

  void _exit() {
    Navigator.pop(context);
  }

  Widget _textInput() {
    return TextInputWidget(
      title: "Edit Duration",
      subtitle: "Seconds",
      hintText: "56",
      action: _action,
      actionText: "Set Duration",
      keyboardType: TextInputType.number,
      altAction: _exit,
      altActionText: "Cancel",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Base(child: _textInput());
  }
}
