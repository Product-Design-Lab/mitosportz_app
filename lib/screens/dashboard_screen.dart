import 'package:flutter/material.dart';

import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';
import 'package:mitosportz/widgets/base.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Widget _tab(String text) {
    return Tab(height: 56, child: Text(text, style: TextStyles.body));
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 16,
      backgroundColor: AppColors.background,
      bottom: TabBar(
          dividerHeight: 0,
          splashBorderRadius: const BorderRadius.all(Radius.circular(32)),
          padding: const EdgeInsets.only(left: 16, right: 16),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: const BoxDecoration(
              color: AppColors.backgroundElevated,
              borderRadius: BorderRadius.all(Radius.circular(32))),
          tabs: [_tab("Metrics"), _tab("Controls")]),
    );
  }

  Widget _body() {
    return const TabBarView(children: [
      Center(child: Text("Hello A")),
      Center(child: Text("Hello B")),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, child: Base(appBar: _appBar(), child: _body()));
  }
}
