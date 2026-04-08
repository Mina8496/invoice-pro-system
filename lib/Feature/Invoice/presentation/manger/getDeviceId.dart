import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

Future<String> getDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isWindows) {
    final windows = await deviceInfo.windowsInfo;

    return "${windows.computerName}_${windows.systemMemoryInMegabytes}";
  } else if (Platform.isAndroid) {
    final android = await deviceInfo.androidInfo;
    return android.id;
  } else {
    return "unknown_device";
  }
}
