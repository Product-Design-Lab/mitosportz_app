import 'package:flutter/material.dart';
import 'package:mitosportz/model/device.dart';
import 'package:mitosportz/widgets/base.dart';
import 'package:mitosportz/widgets/device_widget.dart';

class DevicesScreen extends StatefulWidget {
  final List<Device> devices;

  const DevicesScreen({Key? key, required this.devices}) : super(key: key);

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  List<Widget> _buildDevicesWidgetList() {
    return widget.devices.map((d) {
      return DeviceWidget(device: d.device, info: d.info);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: Column(
      children: _buildDevicesWidgetList(),
    ));
  }
}
