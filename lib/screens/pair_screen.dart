import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/widgets/base.dart';
import 'package:mitosportz/widgets/text_input_widget.dart';

class PairingScreen extends StatefulWidget {
  const PairingScreen({Key? key}) : super(key: key);

  @override
  State<PairingScreen> createState() => _PairingScreenState();
}

class _PairingScreenState extends State<PairingScreen> {
  String? error;
  String? pairingCode;

  BluetoothDevice? deviceA;
  BluetoothDevice? deviceB;

  final String devicePrefix = "MS";

  @override
  void initState() {
    super.initState();
  }

  void action(String value) {
    setState(() {
      error = _validator(value);
    });
    if (error == null) {
      setState(() {
        pairingCode = value;
      });
      _scan();
    }
  }

  bool _isNumeric(String value) {
    return num.tryParse(value) != null;
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a 4 digit code";
    }
    if (value.length != 4) {
      return "Pairing code is 4 digits";
    }
    if (!_isNumeric(value)) {
      return "Please enter digits";
    }
    return null;
  }

  void _connect() async {
    if (deviceA != null) {
      await deviceA?.connect();
      print('Connected to ${deviceA?.platformName}');
    }
  }

  void _scan() async {
    await FlutterBluePlus.startScan();
    FlutterBluePlus.scanResults.listen((results) async {
      for (ScanResult result in results) {
        print(result.device.platformName);
        if (result.device.platformName == "${devicePrefix}_A_${pairingCode}") {
          deviceA = result.device;
        }
        if (deviceA != null) {
          FlutterBluePlus.stopScan();
          _connect();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: TextInputWidget(
      title: "Enter Pairing Code",
      subtitle: "Use your 4-digit device code to connect",
      hintText: "1234",
      action: action,
      actionText: "Connect",
      errorText: error,
      keyboardType: TextInputType.number,
    ));
  }
}
