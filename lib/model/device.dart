class Device {
  static const String name = "Mitosports_01";

  static const String service = "20B10020-E8F2-537E-4F6C-D104768A1214";

  static const String heartRateCharacteristic =
      "20B10022-E8F2-537E-4F6C-D104768A1214"; // Heart rate
  static const String bloodOxygenCharacteristic =
      "20B10021-E8F2-537E-4F6C-D104768A1214"; // Pulse Oximetry
  static const String batteryLevelCharacteristic =
      "20B10020-E8F2-537E-4F6C-D104768A1214"; // The battery level of the device from 0-100

  static const String resetCharacteristic =
      "20B10023-E8F2-537E-4F6C-D104768A1214"; // Resets the device and the app
  static const String ledOnTimeCharacteristic =
      "20B10024-E8F2-537E-4F6C-D104768A1214"; // LED On Time
  static const String laserDiodeTimingCharacteristic =
      "20B10025-E8F2-537E-4F6C-D104768A1214"; // Laser Diode Timing
  static const String laserDiodeDelayCharacteristic =
      "20B10026-E8F2-537E-4F6C-D104768A1214"; // Laser Diode Delay
}
