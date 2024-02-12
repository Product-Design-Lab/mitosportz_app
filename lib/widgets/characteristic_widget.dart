import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mitosportz/model/device.dart';

class CharacteristicWidget extends StatefulWidget {
  final BluetoothCharacteristic characteristic;

  const CharacteristicWidget({Key? key, required this.characteristic})
      : super(key: key);

  @override
  State<CharacteristicWidget> createState() => _CharacteristicWidgetState();
}

class _CharacteristicWidgetState extends State<CharacteristicWidget> {
  List<int> _value = [];

  BluetoothCharacteristic get c => widget.characteristic;

  late StreamSubscription<List<int>> _valueSubscription;

  @override
  void initState() {
    super.initState();
    update();
  }

  @override
  void dispose() {
    _valueSubscription.cancel();
    super.dispose();
  }

  void update() async {
    try {
      await c.read();
      _valueSubscription = c.onValueReceived.listen((value) async {
        setState(() {
          _value = value;
        });
      });
      await c.setNotifyValue(true);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var label =
        Characteristics.labels[c.uuid.toString().toUpperCase()] ?? "(Unnamed)";

    return Row(
      children: [
        Text(label),
        Spacer(),
        Text(_value.toString()),
      ],
    );
  }
}
