import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/constants/colors.dart';

import 'package:mitosportz/model/device.dart';

import 'package:mitosportz/widgets/base.dart';
import 'package:mitosportz/widgets/sequence_input_widget.dart';

class EditLaserTimingScreen extends StatefulWidget {
  final BluetoothDevice? device;

  const EditLaserTimingScreen({Key? key, this.device}) : super(key: key);

  @override
  State<EditLaserTimingScreen> createState() => _EditLaserTimingScreenState();
}

class _EditLaserTimingScreenState extends State<EditLaserTimingScreen> {
  List<int> laserTiming = [];
  int duration = 0;

  @override
  void initState() {
    super.initState();
    _connect();
  }

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
        if (c.uuid.toString().toUpperCase() == Characteristics.laserTiming) {
          List<int> value = await c.read();
          setState(() {
            laserTiming = value;
          });
        }

        if (c.uuid.toString().toUpperCase() ==
            Characteristics.sessionDuration) {
          List<int> value = await c.read();
          setState(() {
            duration = value[0];
          });
        }
      });
    });
  }

  void _submit(List<bool> value) async {
    List<int> submittedValue = _convert(value);

    List<BluetoothService>? services = await widget.device?.discoverServices();

    services?.forEach((s) async {
      s.characteristics.forEach((c) async {
        if (c.uuid.toString().toUpperCase() == Characteristics.laserTiming) {
          await c.write(submittedValue);
          _exit();
        }
      });
    });
  }

  void _exit() {
    Navigator.pop(context);
  }

  List<int> _convert(List<bool> list) {
    return list.map((e) => e ? 1 : 0).toList();
  }

  List<int> _encode(List<bool> list) {
    return utf8.encode(list.map((val) => (val ? "1" : "0")).join());
  }

  List<bool> _decode(List<int> list) {
    return utf8
        .decode(list)
        .toString()
        .split('')
        .map((character) => (character == "1") ? true : false)
        .toList();
  }

  Widget _sequenceInput() {
    return SequenceInputWidget(
      title: "Edit Laser Timing",
      subtitle: laserTiming.isNotEmpty
          ? "Each bar is ${((duration / laserTiming.length)*60).round()} seconds"
          : "",
      initialValue: _decode(laserTiming),
      action: _submit,
      actionText: "Set Sequence",
      altAction: _exit,
      altActionText: "Cancel",
      themeColor: AppColors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Base(child: _sequenceInput());
  }
}
