import 'package:flutter_blue_plus/flutter_blue_plus.dart';

const characteristics = {
  "20B10021-E8F2-537E-4F6C-D104768A1214": {
    "label": "Battery Level",
    "type": DataType.int,
  },
  "20B10022-E8F2-537E-4F6C-D104768A1214": {
    "label": "Session Duration",
    "type": DataType.int,
  },
  "20B10023-E8F2-537E-4F6C-D104768A1214": {
    "label": "LED Timing",
    "type": DataType.string,
  },
  "20B10024-E8F2-537E-4F6C-D104768A1214": {
    "label": "Laser Timing",
    "type": DataType.string,
  },
  "20B10025-E8F2-537E-4F6C-D104768A1214": {
    "label": "Active Lasers",
    "type": DataType.int,
  },
  "20B10026-E8F2-537E-4F6C-D104768A1214": {
    "label": "Laser Power",
    "type": DataType.int,
  },
  "20B10027-E8F2-537E-4F6C-D104768A1214": {
    "label": "Reset",
    "type": DataType.int,
  },
};

enum DataType { int, bool, string, none }

class Device {
  final DeviceInfo info;
  final BluetoothDevice device;

  Device({
    required this.info,
    required this.device,
  });
}

class DeviceInfo {
  final String name;
  final String serviceID;
  final Map characteristics;

  DeviceInfo({
    required this.name,
    required this.serviceID,
    required this.characteristics,
  });
}

class RegisteredDevices {
  static List<DeviceInfo> devices = [
    DeviceInfo(
      name: "MS_01_A-1234",
      serviceID: "20B10020-E8F2-537E-4F6C-D104768A1214",
      characteristics: characteristics,
    ),
    // DeviceInfo(
    //   name: "MS_01_B-1234",
    //   serviceID: "20B10020-E8F2-537E-4F6C-D104768A1214",
    //   characteristics: characteristics,
    // ),
  ];
}
