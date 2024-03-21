import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';
import 'package:mitosportz/constants/widget_styles.dart';

import 'package:mitosportz/model/device.dart';

import 'package:mitosportz/widgets/progress_widget.dart';

class DeviceWidget extends StatefulWidget {
  final String name;
  final BluetoothDevice? device;

  const DeviceWidget({Key? key, required this.name, this.device})
      : super(key: key);

  @override
  State<DeviceWidget> createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceWidget> {
  StreamSubscription<List<int>>? _batterySubscription;

  int batteryLevel = 0;

  @override
  void initState() {
    super.initState();
    _connect();
  }

  @override
  void dispose() {
    _batterySubscription?.cancel();
    super.dispose();
  }

  bool _hasDevice() => widget.device != null;

  void _connect() {
    widget.device?.connectionState.listen((state) async {
      if (state == BluetoothConnectionState.disconnected) {
        await widget.device?.connect();
      }

      if (state == BluetoothConnectionState.connected) {
        _update();
      }
    });
  }

  void _update() async {
    List<BluetoothService>? services = await widget.device?.discoverServices();

    services?.forEach((s) async {
      s.characteristics.forEach((c) async {
        if (c.uuid.toString().toUpperCase() == Characteristics.battery) {
          await c.read();
          _batterySubscription = c.onValueReceived.listen((value) async {
            setState(() {
              batteryLevel = value[0];
            });
          });
          await c.setNotifyValue(true);
        }
      });
    });
  }

  Widget _title() {
    return Text(widget.name,
        style: TextStyles.body.copyWith(color: AppColors.green));
  }

  Widget _status() {
    String label = _hasDevice() ? "$batteryLevel% battery" : "Not Connected";
    double level = _hasDevice() ? (batteryLevel / 100) : 0;
    Color color =
        _hasDevice() ? AppColors.labelSecondary : AppColors.labelTertiary;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child:
              Text(label, style: TextStyles.smallBody.copyWith(color: color)),
        ),
        ProgressWidget(color: AppColors.green, progress: level)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 168,
        decoration: WidgetStyles.elevatedCard,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [_title(), _status()]),
        ),
      ),
    );
  }
}
