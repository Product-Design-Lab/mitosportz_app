class CharacteristicID {
  final String heartRate;
  final String bloodOxygen;
  final String batteryLevel;
  final String reset;
  final String ledOnTime;
  final String laserDiode;
  final String laserDiodeDelay;

  CharacteristicID({
    required this.heartRate,
    required this.bloodOxygen,
    required this.batteryLevel,
    required this.reset,
    required this.ledOnTime,
    required this.laserDiode,
    required this.laserDiodeDelay,
  });
}

class Device {
  final String name;
  final String service;
  final CharacteristicID characteristicID;

  Device({
    required this.name,
    required this.service,
    required this.characteristicID,
  });
}

class Devices {
  static Device deviceA = Device(
      name: "Mitosports_01_A",
      service: "20B10020-E8F2-537E-4F6C-D104768A1214",
      characteristicID: CharacteristicID(
          heartRate: "20B10022-E8F2-537E-4F6C-D104768A1214",
          bloodOxygen: "20B10021-E8F2-537E-4F6C-D104768A1214",
          batteryLevel: "20B10020-E8F2-537E-4F6C-D104768A1214",
          reset: "20B10023-E8F2-537E-4F6C-D104768A1214",
          ledOnTime: "20B10024-E8F2-537E-4F6C-D104768A1214",
          laserDiode: "20B10025-E8F2-537E-4F6C-D104768A1214",
          laserDiodeDelay: "20B10026-E8F2-537E-4F6C-D104768A1214"));

  static Device deviceB = Device(
      name: "Mitosports_01_B",
      service: "20B10020-E8F2-537E-4F6C-D104768A1214",
      characteristicID: CharacteristicID(
          heartRate: "20B10022-E8F2-537E-4F6C-D104768A1214",
          bloodOxygen: "20B10021-E8F2-537E-4F6C-D104768A1214",
          batteryLevel: "20B10020-E8F2-537E-4F6C-D104768A1214",
          reset: "20B10023-E8F2-537E-4F6C-D104768A1214",
          ledOnTime: "20B10024-E8F2-537E-4F6C-D104768A1214",
          laserDiode: "20B10025-E8F2-537E-4F6C-D104768A1214",
          laserDiodeDelay: "20B10026-E8F2-537E-4F6C-D104768A1214"));
}
