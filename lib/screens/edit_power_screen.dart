import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/constants/colors.dart';

import 'package:mitosportz/model/device.dart';

import 'package:mitosportz/widgets/base.dart';
import 'package:mitosportz/widgets/slider_input_widget.dart';

class EditPowerScreen extends StatefulWidget {
  final BluetoothDevice? device;

  const EditPowerScreen({Key? key, this.device}) : super(key: key);

  @override
  State<EditPowerScreen> createState() => _EditPowerScreenState();
}

class _EditPowerScreenState extends State<EditPowerScreen> {
  int power = 0;

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
        if (c.uuid.toString().toUpperCase() == Characteristics.laserPower) {
          List<int> value = await c.read();
          setState(() {
            power = value[0];
          });
        }
      });
    });
  }

  void _submit(double value) async {
    int submittedValue = value.round().toInt();

    List<BluetoothService>? services = await widget.device?.discoverServices();

    services?.forEach((s) async {
      s.characteristics.forEach((c) async {
        if (c.uuid.toString().toUpperCase() == Characteristics.laserPower) {
          await c.write([submittedValue]);
          _exit();
        }
      });
    });
  }

  void _exit() {
    Navigator.pop(context);
  }

  Widget _sliderInput() {
    return SliderInputWidget(
      title: "Edit Laser Power",
      label: "%",
      initialValue: power.toDouble(),
      action: _submit,
      actionText: "Set Power",
      altAction: _exit,
      altActionText: "Cancel",
      themeColor: AppColors.orange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Base(child: _sliderInput());
  }
}
