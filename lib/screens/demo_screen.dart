import 'package:flutter/material.dart';

import 'package:mitosportz/widgets/base.dart';
import 'package:mitosportz/widgets/sequence_input_widget.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  void action(List<bool> value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: Center(
      child: SequenceInputWidget(
          title: "Edit Sequence",
          subtitle: "Each bar is 50 seconds",
          initialValue: const [
            true,
            true,
            false,
            false,
            true,
            true,
            false,
            false
          ],
          action: action,
          actionText: "Submit"),
    ));
  }
}
