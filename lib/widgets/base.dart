import 'package:flutter/material.dart';

import 'package:mitosportz/constants/colors.dart';

class Base extends StatelessWidget {
  final Widget child;
  final bool showBackButton;

  const Base({super.key, required this.child, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leading: showBackButton
              ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: AppColors.labelPrimary,
                )
              : null,
          backgroundColor: AppColors.background,
          shadowColor: Colors.transparent,
        ),
        body: SafeArea(
            child: Padding(padding: const EdgeInsets.all(16), child: child)));
  }
}
