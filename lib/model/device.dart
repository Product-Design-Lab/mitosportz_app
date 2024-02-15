const characteristics = {
  "20B10021-E8F2-537E-4F6C-D104768A1214": {
    "label": "Battery Level",
    "type": DataType.int,
  },
  "20B10022-E8F2-537E-4F6C-D104768A1214": {
    "label": "Heart Rate",
    "type": DataType.int,
  },
  "20B10023-E8F2-537E-4F6C-D104768A1214": {
    "label": "Blood Oxygen",
    "type": DataType.int,
  },
  "20B10024-E8F2-537E-4F6C-D104768A1214": {
    "label": "Session Duration",
    "type": DataType.int,
  },
  "20B10025-E8F2-537E-4F6C-D104768A1214": {
    "label": "Active Laser Proportion",
    "type": DataType.int,
  },
  "20B10026-E8F2-537E-4F6C-D104768A1214": {
    "label": "Laser Power Level",
    "type": DataType.int,
  },
  "20B10027-E8F2-537E-4F6C-D104768A1214": {
    "label": "LED Timing",
    "type": DataType.int,
  },
  "20B10028-E8F2-537E-4F6C-D104768A1214": {
    "label": "Laser Timing",
    "type": DataType.int,
  },
  "20B10029-E8F2-537E-4F6C-D104768A1214": {
    "label": "Reset",
    "type": DataType.int,
  },
};

enum DataType { int, bool, array, none }

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
      name: "Mitosports_01_A",
      serviceID: "20B10020-E8F2-537E-4F6C-D104768A1214",
      characteristics: characteristics,
    ),
    DeviceInfo(
      name: "Mitosports_01_B",
      serviceID: "20B10020-E8F2-537E-4F6C-D104768A1214",
      characteristics: characteristics,
    ),
  ];
}
