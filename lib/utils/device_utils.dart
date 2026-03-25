import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceUtils {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<String> getDeviceId() async {
    try {
      if (kIsWeb) {
        final webInfo = await _deviceInfo.webBrowserInfo;
        return webInfo.userAgent ?? 'unknown-web';
      }

      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        // androidId is unique per device + app signing key
        return androidInfo.id; // e.g. "9774d56d682e549c"
      }

      if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        // identifierForVendor is unique per device per vendor
        return iosInfo.identifierForVendor ?? 'unknown-ios';
      }
    } catch (e) {
      debugPrint('Failed to get device ID: $e');
    }

    return 'unknown';
  }
}
