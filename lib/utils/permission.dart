import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestStoragePermission() async {
  // Check if the device is running Android 13 or above
  if (Platform.isAndroid && (await _isAndroid13OrAbove())) {
    final status = await Permission.photos.status;
    if (status.isDenied || status.isRestricted) {
      await openAppSettings();
      final result = await Permission.photos.request();
      if (result.isGranted) {
        print('Photos permission granted');
        return true;
      } else {
        print('Photos permission denied');
        return false;
      }
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    } else {
      return true;
    }
  } else {
    // For Android versions below 13
    final status = await Permission.storage.status;
    if (status.isDenied || status.isRestricted) {
      final result = await Permission.storage.request();
      if (result.isGranted) {
        print('Storage permission granted');
        return true;
      } else {
        print('Storage permission denied');
        return false;
      }
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    } else {
      return true;
    }
  }
}

Future<bool> _isAndroid13OrAbove() async {
  try {
    // Obtain the Android SDK version

    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.androidInfo;
    final sdkInt = deviceInfo.version.sdkInt;
    log(sdkInt.toString());
    if (sdkInt >= 33) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Failed to get Android version: $e');
    return false;
  }
}
