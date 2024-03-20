import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';

import 'package:mitosportz/widgets/base.dart';
import 'package:mitosportz/widgets/device_widget.dart';

class DashboardScreen extends StatefulWidget {
  final List<BluetoothDevice?> devices;

  const DashboardScreen({Key? key, required this.devices}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool devicesReady() {
    bool ready = true;
    widget.devices.forEach((device) {
      if (device == null) {
        ready = false;
      }
    });
    return ready;
  }

  Widget _empty(String text) {
    return Center(
      child: Text(text,
          style: TextStyles.body.copyWith(color: AppColors.labelTertiary)),
    );
  }

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

  Widget _metricsTab() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DeviceWidget(),
            SizedBox(width: 16),
            DeviceWidget(),
          ],
        )
      ],
    );
  }

  Widget _body() {
    return TabBarView(children: [
      devicesReady() ? _metricsTab() : _empty("No Devices Connected"),
      _empty("No Devices Connected")
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, child: Base(appBar: _appBar(), child: _body()));
  }
}
