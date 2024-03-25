import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/constants/colors.dart';

import 'package:mitosportz/model/device.dart';

import 'package:mitosportz/widgets/base.dart';
import 'package:mitosportz/widgets/slider_input_widget.dart';

class EditProportionScreen extends StatefulWidget {
  final BluetoothDevice? device;

  const EditProportionScreen({Key? key, this.device}) : super(key: key);

  @override
  State<EditProportionScreen> createState() => _EditProportionScreenState();
}

class _EditProportionScreenState extends State<EditProportionScreen> {
  int proportion = 0;

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
        if (c.uuid.toString().toUpperCase() == Characteristics.activeLasers) {
          List<int> value = await c.read();
          setState(() {
            proportion = value[0];
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
        if (c.uuid.toString().toUpperCase() == Characteristics.activeLasers) {
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
      title: "Edit Active Lasers",
      label: "%",
      initialValue: proportion.toDouble(),
      action: _submit,
      actionText: "Set Proportion",
      altAction: _exit,
      altActionText: "Cancel",
      themeColor: AppColors.yellow,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Base(child: _sliderInput());
  }
}
