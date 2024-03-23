import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/model/device.dart';

import 'package:mitosportz/widgets/base.dart';
import 'package:mitosportz/widgets/text_input_widget.dart';

class EditDurationScreen extends StatefulWidget {
  final BluetoothDevice? device;

  const EditDurationScreen({Key? key, this.device}) : super(key: key);

  @override
  State<EditDurationScreen> createState() => _EditDurationScreenState();
}

class _EditDurationScreenState extends State<EditDurationScreen> {
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

  void _action(String value) {
    _exit();
  }

  void _exit() {
    Navigator.pop(context);
  }

  Widget _textInput() {
    return TextInputWidget(
      title: "Edit Duration",
      subtitle: "Seconds",
      hintText: "$duration",
      action: _action,
      actionText: "Set Duration",
      keyboardType: TextInputType.number,
      altAction: _exit,
      altActionText: "Cancel",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Base(child: _textInput());
  }
}
