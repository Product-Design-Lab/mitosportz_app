import 'dart:async';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/constants/text_styles.dart';
import 'package:mitosportz/model/device.dart';

class CharacteristicWidget extends StatefulWidget {
  final BluetoothCharacteristic characteristic;
  final String label;
  final DataType type;

  const CharacteristicWidget(
      {Key? key,
      required this.characteristic,
      required this.label,
      required this.type})
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

  String format(List<int> value) {
    if (value.isEmpty) {
      return "null";
    }

    switch (widget.type) {
      case DataType.int:
        return value[0].toString();
      case DataType.string:
        return utf8.decode(value).toString();
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.label, style: TextStyles.body),
        Spacer(),
        Text(format(_value), style: TextStyles.body),
      ],
    );
  }
}
