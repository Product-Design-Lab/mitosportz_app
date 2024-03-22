import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/constants/button_styles.dart';
import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';

import 'package:mitosportz/model/device.dart';

import 'package:mitosportz/widgets/progress_widget.dart';

class ProportionWidget extends StatefulWidget {
  final BluetoothDevice? device;

  const ProportionWidget({Key? key, this.device}) : super(key: key);

  @override
  State<ProportionWidget> createState() => _ProportionWidgetState();
}

class _ProportionWidgetState extends State<ProportionWidget> {
  StreamSubscription<List<int>>? _proportionSubscription;

  int proportion = 0;

  @override
  void initState() {
    super.initState();
    _connect();
  }

  @override
  void dispose() {
    _proportionSubscription?.cancel();
    super.dispose();
  }

  // TODO: Implement Empty State
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
        if (c.uuid.toString().toUpperCase() == Characteristics.laserPower) {
          await c.read();
          _proportionSubscription = c.onValueReceived.listen((value) async {
            setState(() {
              proportion = value[0];
            });
          });
          await c.setNotifyValue(true);
        }
      });
    });
  }

  void _action() {}

  Widget _title() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Active Lasers",
            style: TextStyles.body.copyWith(color: AppColors.yellow)),
        Text("Edit",
            style:
                TextStyles.smallBody.copyWith(color: AppColors.labelSecondary))
      ],
    );
  }

  Widget _status() {
    String label = _hasDevice() ? "$proportion%" : "Not Connected";
    double level = _hasDevice() ? (proportion / 100) : 0;
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
        ProgressWidget(color: AppColors.yellow, progress: level)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyles.buttonCard,
        onPressed: _action,
        child: SizedBox(
          height: 168,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [_title(), _status()]),
          ),
        ),
      ),
    );
  }
}
