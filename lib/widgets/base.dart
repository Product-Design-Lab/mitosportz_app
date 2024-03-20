import 'package:flutter/material.dart';

import 'package:mitosportz/constants/colors.dart';

class Base extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;

  const Base({super.key, required this.child, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: appBar,
        body: SafeArea(
            child: Padding(padding: const EdgeInsets.all(16), child: child)));
  }
}
