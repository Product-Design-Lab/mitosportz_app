import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:app_template/model.dart';

import 'package:app_template/widgets/base.dart';

class DeviceScreen extends StatefulWidget {
  final BluetoothDevice device;

  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  late Timer _timer;

  int exampleCharacteristic = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      update();
    });
  }

  void update() async {
    List<BluetoothService> services = await widget.device.discoverServices();

    services.forEach((service) async {
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        List<int> value = await c.read();

        // exampleCharacteristic
        if (c.uuid.toString() == Device.exampleCharacteristic.toLowerCase()) {
          setState(() {
            exampleCharacteristic = value[0];
          });
        }
      }
    });
  }

  void exampleAction() async {
    List<BluetoothService> services = await widget.device.discoverServices();

    services.forEach((service) async {
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        // Example Action Characteristic
        if (c.uuid.toString() ==
            Device.exampleActionCharacteristic.toLowerCase()) {
          c.write([0]);
        }
      }
    });
  }

  void exit() {
    widget.device.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text("Example Characterstic: $exampleCharacteristic")),
        MaterialButton(
            onPressed: exampleAction, child: const Text("Example Action"))
      ],
    ));
  }
}
