import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';

import 'package:mitosportz/model/device.dart';
import 'package:mitosportz/screens/devices_screen.dart';

import 'package:mitosportz/widgets/base.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: AppColors.background,
        home: StreamBuilder<BluetoothAdapterState>(
          stream: FlutterBluePlus.adapterState,
          initialData: BluetoothAdapterState.unknown,
          builder: (context, snapshot) {
            if (snapshot.data == BluetoothAdapterState.on) {
              return const _ScannerScreen();
            }
            return const _StatusScreen(text: "Bluetooth is Off");
          },
        ));
  }
}

class _ScannerScreen extends StatelessWidget {
  const _ScannerScreen({Key? key}) : super(key: key);

  void scan(BuildContext context) async {
    List<Device> detectedDevices = [];

    await FlutterBluePlus.startScan();
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        print(result.device.platformName);
        RegisteredDevices.devices.forEach((registeredDevice) {
          bool alreadyRegisted = detectedDevices.any((detectedDevice) =>
              detectedDevice.device.platformName == result.device.platformName);
          if ((result.device.platformName == registeredDevice.name) &&
              !alreadyRegisted) {
            detectedDevices
                .add(Device(info: registeredDevice, device: result.device));
          }
        });

        if (detectedDevices.length == RegisteredDevices.devices.length) {
          FlutterBluePlus.stopScan();
          detectedDevices.forEach((detectedDevice) async {
            await detectedDevice.device.connect();
            print('Connected to ${detectedDevice.device.platformName}');
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DevicesScreen(devices: detectedDevices)));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    scan(context);
    return const _StatusScreen(text: "Connecting...");
  }
}

class _StatusScreen extends StatelessWidget {
  final String text;

  const _StatusScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Base(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child:
              Center(child: Text("Connecting...", style: TextStyles.subtitle)),
        ),
        Text("Ensure your device is on and nearby",
            style: TextStyles.body.copyWith(color: AppColors.labelSecondary))
      ],
    ));
  }
}
