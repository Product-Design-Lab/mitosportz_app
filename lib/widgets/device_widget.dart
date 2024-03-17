import 'dart:async';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mitosportz/constants/button_styles.dart';

import 'package:mitosportz/constants/text_styles.dart';
import 'package:mitosportz/model/device.dart';

import 'package:mitosportz/widgets/characteristic_widget.dart';

class DeviceWidget extends StatefulWidget {
  final BluetoothDevice device;
  final DeviceInfo info;

  const DeviceWidget({Key? key, required this.device, required this.info})
      : super(key: key);

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

  void set(String array) async {
    try {
      _services.forEach((s) async {
        s.characteristics.forEach((c) {
          if (c.uuid.toString().toUpperCase() ==
              "20B10023-E8F2-537E-4F6C-D104768A1214") {
            c.write(utf8.encode(array));
          }
        });
      });
    } catch (e) {
      print(e);
    }
  }

  List<Widget> _buildServicesList() {
    return _services.map((s) => Text(s.uuid.toString())).toList();
  }

  List<Widget> _buildCharacteristicWidgetList() {
    if (_services.isEmpty) {
      return [
        const Text(
          "Connecting...",
          style: TextStyles.body,
        )
      ];
    }

    List<Widget> w = [];

    _services.forEach((s) {
      s.characteristics.forEach((c) {
        var info = widget.info.characteristics[c.uuid.toString().toUpperCase()];
        w.add(CharacteristicWidget(
          characteristic: c,
          label: info["label"],
          type: info["type"],
        ));
      });
    });

    return w;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.info.name, style: TextStyles.subtitle),
          Column(
            children: _buildCharacteristicWidgetList(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () => set("11110000"),
                      style: ButtonStyles.buttonPrimary,
                      child: const Text("Set LED Timing")),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: ElevatedButton(
                        onPressed: () => set("00000000"),
                        style: ButtonStyles.buttonPrimary,
                        child: const Text("Clear LED Timing")),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
