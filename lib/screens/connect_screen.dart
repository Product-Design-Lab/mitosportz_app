import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';

import 'package:mitosportz/model/device.dart';

import 'package:mitosportz/widgets/base.dart';

import 'package:mitosportz/screens/multi_device_screen.dart';
import 'package:mitosportz/screens/device_screen.dart';

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

  void connect(BuildContext context) async {
    BluetoothDevice? deviceA;
    BluetoothDevice? deviceB;
    var _connectedCount = 0;

    await FlutterBluePlus.startScan();
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (result.device.platformName == Devices.deviceA.name) {
          print('Detected Device A');
          deviceA = result.device;
          result.device.connect();
        }

        if (result.device.platformName == Devices.deviceB.name) {
          print('Detected Device B');
          deviceB = result.device;
          result.device.connect();
        }

        if ((deviceA != null) && (deviceB != null)) {
          FlutterBluePlus.stopScan();
          print('Both devices connected');

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MultiDeviceScreen(deviceA: deviceA, deviceB: deviceB)));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    connect(context);
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
