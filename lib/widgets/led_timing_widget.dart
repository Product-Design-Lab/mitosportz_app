import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/constants/button_styles.dart';
import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';

import 'package:mitosportz/model/device.dart';
import 'package:mitosportz/widgets/sequence_widget.dart';

class LEDTimingWidget extends StatefulWidget {
  final BluetoothDevice? device;

  const LEDTimingWidget({Key? key, this.device}) : super(key: key);

  @override
  State<LEDTimingWidget> createState() => _LEDTimingWidgetState();
}

class _LEDTimingWidgetState extends State<LEDTimingWidget> {
  List<int> ledTiming = [];

  @override
  void initState() {
    super.initState();
    _connect();
  }

  // TODO: Implement Empty State
  bool _hasDevice() => widget.device != null;

  void _connect() {
    widget.device?.connectionState.listen((state) async {
      if (state == BluetoothConnectionState.disconnected) {
        await widget.device?.connect();
      }

      if (state == BluetoothConnectionState.connected) {
        _update();
      }
    });
  }

  void _update() async {
    List<BluetoothService>? services = await widget.device?.discoverServices();

    services?.forEach((s) async {
      s.characteristics.forEach((c) async {
        if (c.uuid.toString().toUpperCase() == Characteristics.ledTiming) {
          List<int> value = await c.read();
          setState(() {
            ledTiming = value;
          });
        }
      });
    });
  }

  void _action() {}

  List<bool> _format() {
    return utf8
        .decode(ledTiming)
        .toString()
        .split('')
        .map((character) => (character == "1") ? true : false)
        .toList();
  }

  Widget _title() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("LED Timing",
            style: TextStyles.body.copyWith(color: AppColors.green)),
        Text("Edit",
            style:
                TextStyles.smallBody.copyWith(color: AppColors.labelSecondary))
      ],
    );
  }

  Widget _status() {
    List<bool> sequence = _format();
    return SequenceWidget(color: AppColors.green, sequence: sequence);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyles.buttonCard,
        onPressed: _action,
        child: SizedBox(
          height: 256,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [_title(), _status()]),
          ),
        ),
      ),
    );
  }
}
