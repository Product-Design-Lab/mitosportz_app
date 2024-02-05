import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/model/device.dart';

import 'package:mitosportz/widgets/base.dart';

class MultiDeviceScreen extends StatefulWidget {
  final BluetoothDevice? deviceA;
  final BluetoothDevice? deviceB;

  const MultiDeviceScreen(
      {Key? key, required this.deviceA, required this.deviceB})
      : super(key: key);

  @override
  State<MultiDeviceScreen> createState() => _MultiDeviceScreenState();
}

class _MultiDeviceScreenState extends State<MultiDeviceScreen> {
  BluetoothConnectionState _connectionStateA =
      BluetoothConnectionState.disconnected;

  StreamSubscription<BluetoothConnectionState>? _connectionStateSubscriptionA;

  StreamSubscription? _heartRateCharacteristicSubscriptionA;
  StreamSubscription? _bloodOxygenCharacteristicSubscriptionA;
  StreamSubscription? _batteryLevelCharacteristicSubscriptionA;
  StreamSubscription? _sessionDurationCharacteristicSubscriptionA;
  StreamSubscription? _activeLaserProportionCharacteristicSubscriptionA;
  StreamSubscription? _laserPowerLevelCharacteristicSubscriptionA;

  int heartRateA = 0;
  int bloodOxygenA = 0;
  int batteryLevelA = 0;
  int sessionDurationA = 0;
  int activeLaserProportionA = 0;
  int laserPowerLevelA = 0;

  BluetoothConnectionState _connectionStateB =
      BluetoothConnectionState.disconnected;

  StreamSubscription<BluetoothConnectionState>? _connectionStateSubscriptionB;

  StreamSubscription? _heartRateCharacteristicSubscriptionB;
  StreamSubscription? _bloodOxygenCharacteristicSubscriptionB;
  StreamSubscription? _batteryLevelCharacteristicSubscriptionB;
  StreamSubscription? _sessionDurationCharacteristicSubscriptionB;
  StreamSubscription? _activeLaserProportionCharacteristicSubscriptionB;
  StreamSubscription? _laserPowerLevelCharacteristicSubscriptionB;

  int heartRateB = 0;
  int bloodOxygenB = 0;
  int batteryLevelB = 0;
  int sessionDurationB = 0;
  int activeLaserProportionB = 0;
  int laserPowerLevelB = 0;

  @override
  void initState() {
    super.initState();

    _connectionStateSubscriptionA =
        widget.deviceA?.connectionState.listen((state) async {
      if (state == BluetoothConnectionState.connected) {
        update();
      }

      if (state == BluetoothConnectionState.disconnected) {
        await widget.deviceA?.connect();
      }

      setState(() {
        _connectionStateA = state;
      });
    });

    _connectionStateSubscriptionB =
        widget.deviceB?.connectionState.listen((state) async {
      if (state == BluetoothConnectionState.connected) {
        update();
      }

      if (state == BluetoothConnectionState.disconnected) {
        await widget.deviceB?.connect();
      }

      setState(() {
        _connectionStateB = state;
      });
    });
  }

  @override
  void dispose() {
    _heartRateCharacteristicSubscriptionA?.cancel();
    _bloodOxygenCharacteristicSubscriptionA?.cancel();
    _batteryLevelCharacteristicSubscriptionA?.cancel();
    _sessionDurationCharacteristicSubscriptionA?.cancel();
    _activeLaserProportionCharacteristicSubscriptionA?.cancel();
    _laserPowerLevelCharacteristicSubscriptionA?.cancel();

    _heartRateCharacteristicSubscriptionB?.cancel();
    _bloodOxygenCharacteristicSubscriptionB?.cancel();
    _batteryLevelCharacteristicSubscriptionB?.cancel();
    _sessionDurationCharacteristicSubscriptionB?.cancel();
    _activeLaserProportionCharacteristicSubscriptionB?.cancel();
    _laserPowerLevelCharacteristicSubscriptionB?.cancel();
    super.dispose();
  }

  void update() async {
    List<BluetoothService>? servicesA =
        await widget.deviceA?.discoverServices();
    List<BluetoothService>? servicesB =
        await widget.deviceB?.discoverServices();

    servicesA?.forEach((service) async {
      if (service.uuid.toString() == Devices.deviceA.service.toLowerCase()) {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          List<int> value = await c.read();

          // batteryLevel
          if (c.uuid.toString() ==
              Devices.deviceA.characteristicID.batteryLevel.toLowerCase()) {
            _batteryLevelCharacteristicSubscriptionA =
                c.onValueReceived.listen((value) async {
              setState(() {
                batteryLevelA = value[0];
              });
            });
            await c.setNotifyValue(true);
          }

          // heartRate
          if (c.uuid.toString() ==
              Devices.deviceA.characteristicID.heartRate.toLowerCase()) {
            _heartRateCharacteristicSubscriptionA =
                c.onValueReceived.listen((value) async {
              setState(() {
                heartRateA = value[0];
              });
            });
            await c.setNotifyValue(true);
          }

          // bloodOxygen
          if (c.uuid.toString() ==
              Devices.deviceA.characteristicID.bloodOxygen.toLowerCase()) {
            _bloodOxygenCharacteristicSubscriptionA =
                c.onValueReceived.listen((value) async {
              setState(() {
                bloodOxygenA = value[0];
              });
            });
            await c.setNotifyValue(true);
          }

          // sessionDuration
          if (c.uuid.toString() ==
              Devices.deviceA.characteristicID.sessionDuration.toLowerCase()) {
            _sessionDurationCharacteristicSubscriptionA =
                c.onValueReceived.listen((value) async {
              setState(() {
                sessionDurationA = value[0];
              });
            });
            await c.setNotifyValue(true);
          }

          // activeLaserProportion
          if (c.uuid.toString() ==
              Devices.deviceA.characteristicID.activeLaserProportion
                  .toLowerCase()) {
            _activeLaserProportionCharacteristicSubscriptionA =
                c.onValueReceived.listen((value) async {
              setState(() {
                activeLaserProportionA = value[0];
              });
            });
            await c.setNotifyValue(true);
          }

          // laserPowerLevel
          if (c.uuid.toString() ==
              Devices.deviceA.characteristicID.laserPowerLevel.toLowerCase()) {
            _laserPowerLevelCharacteristicSubscriptionA =
                c.onValueReceived.listen((value) async {
              setState(() {
                laserPowerLevelA = value[0];
              });
            });
            await c.setNotifyValue(true);
          }
        }
      }
    });

    servicesB?.forEach((service) async {
      if (service.uuid.toString() == Devices.deviceB.service.toLowerCase()) {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          List<int> value = await c.read();

          // batteryLevel
          if (c.uuid.toString() ==
              Devices.deviceB.characteristicID.batteryLevel.toLowerCase()) {
            _batteryLevelCharacteristicSubscriptionB =
                c.onValueReceived.listen((value) async {
              setState(() {
                batteryLevelB = value[0];
              });
            });
            await c.setNotifyValue(true);
          }

          // heartRate
          if (c.uuid.toString() ==
              Devices.deviceB.characteristicID.heartRate.toLowerCase()) {
            _heartRateCharacteristicSubscriptionB =
                c.onValueReceived.listen((value) async {
              setState(() {
                heartRateB = value[0];
              });
            });
            await c.setNotifyValue(true);
          }

          // bloodOxygen
          if (c.uuid.toString() ==
              Devices.deviceB.characteristicID.bloodOxygen.toLowerCase()) {
            _bloodOxygenCharacteristicSubscriptionB =
                c.onValueReceived.listen((value) async {
              setState(() {
                bloodOxygenB = value[0];
              });
            });
            await c.setNotifyValue(true);
          }

          // sessionDuration
          if (c.uuid.toString() ==
              Devices.deviceB.characteristicID.sessionDuration.toLowerCase()) {
            _sessionDurationCharacteristicSubscriptionB =
                c.onValueReceived.listen((value) async {
              setState(() {
                sessionDurationB = value[0];
              });
            });
            await c.setNotifyValue(true);
          }

          // activeLaserProportion
          if (c.uuid.toString() ==
              Devices.deviceB.characteristicID.activeLaserProportion
                  .toLowerCase()) {
            _activeLaserProportionCharacteristicSubscriptionB =
                c.onValueReceived.listen((value) async {
              setState(() {
                activeLaserProportionB = value[0];
              });
            });
            await c.setNotifyValue(true);
          }

          // laserPowerLevel
          if (c.uuid.toString() ==
              Devices.deviceB.characteristicID.laserPowerLevel.toLowerCase()) {
            _laserPowerLevelCharacteristicSubscriptionB =
                c.onValueReceived.listen((value) async {
              setState(() {
                laserPowerLevelB = value[0];
              });
            });
            await c.setNotifyValue(true);
          }
        }
      }
    });
  }

  void resetActionA() async {
    List<BluetoothService>? services = await widget.deviceA?.discoverServices();

    services?.forEach((service) async {
      if (service.uuid.toString() == Devices.deviceA.service.toLowerCase()) {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          // resetCharacteristic
          if (c.uuid.toString() ==
              Devices.deviceA.characteristicID.reset.toLowerCase()) {
            c.write([0]);
          }
        }
      }
    });
  }

  void resetActionB() async {
    List<BluetoothService>? services = await widget.deviceB?.discoverServices();

    services?.forEach((service) async {
      if (service.uuid.toString() == Devices.deviceB.service.toLowerCase()) {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          // resetCharacteristic
          if (c.uuid.toString() ==
              Devices.deviceB.characteristicID.reset.toLowerCase()) {
            c.write([0]);
          }
        }
      }
    });
  }

  void exit() {
    widget.deviceA?.disconnect();
    widget.deviceB?.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text("Battery Level: $batteryLevelA%")),
        Center(child: Text("Heart Rate: $heartRateA bpm")),
        Center(child: Text("Blood Oxygen Saturation: $bloodOxygenA%")),
        Center(child: Text("Session Duration: $sessionDurationA s")),
        Center(
            child: Text("Active Laser Proportion: $activeLaserProportionA%")),
        Center(child: Text("Laser Power Level: $laserPowerLevelA%")),
        MaterialButton(
            onPressed: resetActionA, child: const Text("Reset Device A")),
        const Spacer(),
        Center(child: Text("Battery Level: $batteryLevelB%")),
        Center(child: Text("Heart Rate: $heartRateB bpm")),
        Center(child: Text("Blood Oxygen Saturation: $bloodOxygenB%")),
        Center(child: Text("Session Duration: $sessionDurationB s")),
        Center(
            child: Text("Active Laser Proportion: $activeLaserProportionB%")),
        Center(child: Text("Laser Power Level: $laserPowerLevelB%")),
        MaterialButton(
            onPressed: resetActionB, child: const Text("Reset Device B")),
      ],
    ));
  }
}
