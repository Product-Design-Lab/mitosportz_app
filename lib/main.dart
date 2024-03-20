import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:mitosportz/constants/widget_styles.dart';

import 'package:mitosportz/screens/pair_screen.dart';

void main() {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    [
      Permission.location,
      Permission.storage,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan
    ].request().then((status) {
      runApp(const MainApp());
    });
  } else {
    runApp(const MainApp());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MitoSportz",
      initialRoute: "/pair",
      routes: {
        "/pair": (context) => const PairingScreen(),
      },
      theme: WidgetStyles.baseTheme,
    );
  }
}
