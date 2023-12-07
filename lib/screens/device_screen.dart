import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:app_template/model/device.dart';

import 'package:app_template/widgets/base.dart';

class DeviceScreen extends StatefulWidget {
  final BluetoothDevice device;

  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;

  StreamSubscription<BluetoothConnectionState>? _connectionStateSubscription;

  StreamSubscription? _heartRateCharacteristicSubscription;
  StreamSubscription? _bloodOxygenCharacteristicSubscription;
  StreamSubscription? _batteryLevelCharacteristicSubscription;

  int heartRate = 0;
  int bloodOxygen = 0;
  int batteryLevel = 0;

  @override
  void initState() {
    super.initState();

    _connectionStateSubscription =
        widget.device.connectionState.listen((state) async {
      if (state == BluetoothConnectionState.connected) {
        update();
      }

      if (state == BluetoothConnectionState.disconnected) {
        await widget.device.connect();
      }

      setState(() {
        _connectionState = state;
      });
    });
  }

  @override
  void dispose() {
    _heartRateCharacteristicSubscription?.cancel();
    _bloodOxygenCharacteristicSubscription?.cancel();
    _batteryLevelCharacteristicSubscription?.cancel();
    super.dispose();
  }

  void update() async {
    List<BluetoothService> services = await widget.device.discoverServices();

    services.forEach((service) async {
      if (service.uuid.toString() == Device.service.toLowerCase()) {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          List<int> value = await c.read();

          // heartRateCharacteristic
          if (c.uuid.toString() ==
              Device.heartRateCharacteristic.toLowerCase()) {
            _heartRateCharacteristicSubscription =
                c.onValueReceived.listen((value) async {
              setState(() {
                heartRate = value[0];
              });
            });
            await c.setNotifyValue(true);
          }

          // bloodOxygenCharacteristic
          if (c.uuid.toString() ==
              Device.bloodOxygenCharacteristic.toLowerCase()) {
            _bloodOxygenCharacteristicSubscription =
                c.onValueReceived.listen((value) async {
              setState(() {
                bloodOxygen = value[0];
              });
            });
            await c.setNotifyValue(true);
          }

          // batteryLevelCharacteristic
          if (c.uuid.toString() ==
              Device.batteryLevelCharacteristic.toLowerCase()) {
            _batteryLevelCharacteristicSubscription =
                c.onValueReceived.listen((value) async {
              setState(() {
                batteryLevel = value[0];
              });
            });
            await c.setNotifyValue(true);
          }
        }
      }
    });
  }

  void resetAction() async {
    List<BluetoothService> services = await widget.device.discoverServices();

    services.forEach((service) async {
      if (service.uuid.toString() == Device.service.toLowerCase()) {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          // resetCharacteristic
          if (c.uuid.toString() == Device.resetCharacteristic.toLowerCase()) {
            c.write([0]);
          }
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
        Center(child: Text("Heart Rate: $heartRate bpm")),
        Center(child: Text("Blood Oxygen Saturation: $bloodOxygen%")),
        Center(child: Text("Battery Level: $batteryLevel%")),
        MaterialButton(onPressed: resetAction, child: const Text("Reset"))
      ],
    ));
  }
}
