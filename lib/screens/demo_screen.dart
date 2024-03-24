import 'package:flutter/material.dart';

import 'package:mitosportz/widgets/base.dart';
import 'package:mitosportz/widgets/slider_input_widget.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  void action(double value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: SliderInputWidget(
            title: "Title", label: "%", action: action, actionText: "Submit"));
  }
}
