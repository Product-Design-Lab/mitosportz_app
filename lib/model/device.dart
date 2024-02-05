class CharacteristicID {
  final String batteryLevel;
  final String heartRate;
  final String bloodOxygen;
  final String sessionDuration;
  final String activeLaserProportion;
  final String laserPowerLevel;
  final String ledTiming;
  final String laserTiming;
  final String reset;

  CharacteristicID({
    required this.batteryLevel,
    required this.heartRate,
    required this.bloodOxygen,
    required this.sessionDuration,
    required this.activeLaserProportion,
    required this.laserPowerLevel,
    required this.ledTiming,
    required this.laserTiming,
    required this.reset,
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
        batteryLevel: "20B10021-E8F2-537E-4F6C-D104768A1214",
        heartRate: "20B10022-E8F2-537E-4F6C-D104768A1214",
        bloodOxygen: "20B10023-E8F2-537E-4F6C-D104768A1214",
        sessionDuration: "20B10024-E8F2-537E-4F6C-D104768A1214",
        activeLaserProportion: "20B10025-E8F2-537E-4F6C-D104768A1214",
        laserPowerLevel: "20B10026-E8F2-537E-4F6C-D104768A1214",
        ledTiming: "20B10027-E8F2-537E-4F6C-D104768A1214",
        laserTiming: "20B10028-E8F2-537E-4F6C-D104768A1214",
        reset: "20B10029-E8F2-537E-4F6C-D104768A1214",
      ));

  static Device deviceB = Device(
      name: "Mitosports_01_B",
      service: "20B10020-E8F2-537E-4F6C-D104768A1214",
      characteristicID: CharacteristicID(
        batteryLevel: "20B10021-E8F2-537E-4F6C-D104768A1214",
        heartRate: "20B10022-E8F2-537E-4F6C-D104768A1214",
        bloodOxygen: "20B10023-E8F2-537E-4F6C-D104768A1214",
        sessionDuration: "20B10024-E8F2-537E-4F6C-D104768A1214",
        activeLaserProportion: "20B10025-E8F2-537E-4F6C-D104768A1214",
        laserPowerLevel: "20B10026-E8F2-537E-4F6C-D104768A1214",
        ledTiming: "20B10027-E8F2-537E-4F6C-D104768A1214",
        laserTiming: "20B10028-E8F2-537E-4F6C-D104768A1214",
        reset: "20B10029-E8F2-537E-4F6C-D104768A1214",
      ));
}
