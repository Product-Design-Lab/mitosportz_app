import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';

import 'package:mitosportz/widgets/base.dart';
import 'package:mitosportz/widgets/device_widget.dart';
import 'package:mitosportz/widgets/duration_widget.dart';
import 'package:mitosportz/widgets/laser_timing_widget.dart';
import 'package:mitosportz/widgets/led_timing_widget.dart';
import 'package:mitosportz/widgets/power_widget.dart';
import 'package:mitosportz/widgets/proportion_widget.dart';

class DashboardScreen extends StatefulWidget {
  final List<BluetoothDevice?> devices;

  const DashboardScreen({Key? key, required this.devices}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    connect();
  }

  bool _devicesReady() {
    bool ready = true;
    widget.devices.forEach((device) {
      if (device == null) {
        ready = false;
      }
    });
    return ready;
  }

  void connect() async {
    if (_devicesReady()) {
      widget.devices.forEach((device) {
        device?.connectionState.listen((state) async {
          if (state == BluetoothConnectionState.disconnected) {
            await device.connect();
            print("Connected to ${device.platformName}");
          }
        });
      });
    }
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
              color: AppColors.tabIndicator,
              borderRadius: BorderRadius.all(Radius.circular(32))),
          tabs: [_tab("Metrics"), _tab("Controls")]),
    );
  }

  Widget _metricsTab() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DeviceWidget(name: "Left Arm", device: widget.devices[0]),
              const SizedBox(width: 16),
              const DeviceWidget(name: "Right Arm")
            ],
          )
        ],
      ),
    );
  }

  Widget _controlsTab() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PowerWidget(
                  device: widget.devices[0],
                ),
                const SizedBox(width: 16),
                ProportionWidget(
                  device: widget.devices[0],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LaserTimingWidget(device: widget.devices[0]),
                const SizedBox(width: 16),
                LEDTimingWidget(device: widget.devices[0]),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DurationWidget(device: widget.devices[0]),
                const SizedBox(width: 16),
                Expanded(child: Container())
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _body() {
    return TabBarView(children: [
      _devicesReady() ? _metricsTab() : _empty("No Devices Connected"),
      _devicesReady() ? _controlsTab() : _empty("No Devices Connected"),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, child: Base(appBar: _appBar(), child: _body()));
  }
}
