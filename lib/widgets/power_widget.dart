import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/constants/button_styles.dart';
import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';

import 'package:mitosportz/model/device.dart';

import 'package:mitosportz/widgets/progress_widget.dart';

import 'package:mitosportz/screens/edit_power_screen.dart';

class PowerWidget extends StatefulWidget {
  final BluetoothDevice? device;

  const PowerWidget({Key? key, this.device}) : super(key: key);

  @override
  State<PowerWidget> createState() => _PowerWidgetState();
}

class _PowerWidgetState extends State<PowerWidget> {
  int power = 0;

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
        if (c.uuid.toString().toUpperCase() == Characteristics.laserPower) {
          List<int> value = await c.read();
          setState(() {
            power = value[0];
          });
        }
      });
    });
  }

  void _action() {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditPowerScreen(device: widget.device)))
        .then((_) => _connect());
  }

  Widget _title() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Laser Power",
            style: TextStyles.body.copyWith(color: AppColors.orange)),
        Text("Edit",
            style:
                TextStyles.smallBody.copyWith(color: AppColors.labelSecondary))
      ],
    );
  }

  Widget _status() {
    String label = _hasDevice() ? "$power%" : "Not Connected";
    double level = _hasDevice() ? (power / 100) : 0;
    Color color =
        _hasDevice() ? AppColors.labelSecondary : AppColors.labelTertiary;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child:
              Text(label, style: TextStyles.smallBody.copyWith(color: color)),
        ),
        ProgressWidget(color: AppColors.orange, progress: level)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyles.buttonCard,
        onPressed: _action,
        child: SizedBox(
          height: 168,
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
