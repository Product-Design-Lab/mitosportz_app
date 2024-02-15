class Characteristics {
  static Map labels = {
    "20B10021-E8F2-537E-4F6C-D104768A1214": "Battery Level",
    "20B10022-E8F2-537E-4F6C-D104768A1214": "Heart Rate",
    "20B10023-E8F2-537E-4F6C-D104768A1214": "Blood Oxygen",
    "20B10024-E8F2-537E-4F6C-D104768A1214": "Session Duration",
    "20B10025-E8F2-537E-4F6C-D104768A1214": "Active Laser Proportion",
    "20B10026-E8F2-537E-4F6C-D104768A1214": "Laser Power Level",
    "20B10027-E8F2-537E-4F6C-D104768A1214": "LED Timing",
    "20B10028-E8F2-537E-4F6C-D104768A1214": "Laser Timing",
    "20B10029-E8F2-537E-4F6C-D104768A1214": "Reset",
  };
}

enum DataType { int, bool, array, none }

class Device {
  final String name;
  final String serviceID;

  Device({
    required this.name,
    required this.serviceID,
  });
}

class Devices {
  static List<Device> list = [
    Device(
        name: "Mitosports_01_A",
        serviceID: "20B10020-E8F2-537E-4F6C-D104768A1214"),
    Device(
        name: "Mitosports_01_B",
        serviceID: "20B10020-E8F2-537E-4F6C-D104768A1214"),
  ];
}
