import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/constants/button_styles.dart';
import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';

import 'package:mitosportz/model/device.dart';
import 'package:mitosportz/screens/edit_duration_screen.dart';

class DurationWidget extends StatefulWidget {
  final BluetoothDevice? device;

  const DurationWidget({Key? key, this.device}) : super(key: key);

  @override
  State<DurationWidget> createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<DurationWidget> {
  StreamSubscription<List<int>>? _durationSubscription;

  int duration = 0;

  @override
  void initState() {
    super.initState();
    _connect();
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
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
        if (c.uuid.toString().toUpperCase() ==
            Characteristics.sessionDuration) {
          await c.read();
          _durationSubscription = c.onValueReceived.listen((value) async {
            setState(() {
              duration = value[0];
            });
          });
          await c.setNotifyValue(true);
        }
      });
    });
  }

  void _action() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditDurationScreen(device: widget.device)));
  }

  Widget _title() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Duration",
            style: TextStyles.body.copyWith(color: AppColors.blue)),
        Text("Edit",
            style:
                TextStyles.smallBody.copyWith(color: AppColors.labelSecondary))
      ],
    );
  }

  Widget _status() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchOutCurve: Curves.decelerate,
          child: Text("$duration",
              key: ValueKey<int>(duration),
              style: TextStyles.title.copyWith(color: AppColors.blue)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 2),
          child: Text("secs",
              style: TextStyles.smallBody
                  .copyWith(color: AppColors.labelSecondary)),
        )
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
