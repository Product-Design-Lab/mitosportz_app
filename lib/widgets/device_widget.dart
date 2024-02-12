import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/widgets/base.dart';

class DeviceWidget extends StatefulWidget {
  final BluetoothDevice device;

  const DeviceWidget({Key? key, required this.device}) : super(key: key);

  @override
  State<DeviceWidget> createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceWidget> {
  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;

  late StreamSubscription<BluetoothConnectionState>
      _connectionStateSubscription;

  List<BluetoothService> _services = [];

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
    _connectionStateSubscription.cancel();
    super.dispose();
  }

  void update() async {
    try {
      _services = await widget.device.discoverServices();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  List<Widget> _buildServicesList() {
    return _services.map((s) => Text(s.uuid.toString())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: Column(
      children: _buildServicesList(),
    ));
  }
}
