import 'package:flutter/material.dart';

import 'package:app_template/widgets/base.dart';

class StatusScreen extends StatelessWidget {
  final String text;

  const StatusScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Base(child: Center(child: Text(text)));
  }
}
