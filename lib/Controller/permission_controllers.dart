import 'package:flutter/services.dart';
import 'package:frido_app/View/PermissionView/location_permission_screen.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionControllers {
  static const MethodChannel _channel = MethodChannel('com.example.permissions/channel');

  // Check Usage Stats permission
  static Future<bool> isUsagePermissionGranted() async {
    try {
      return await _channel.invokeMethod('isUsagePermissionGranted') ?? false;
    } catch (e) {
      return false;
    }
  }

  // Open Usage Access Settings
  static Future<void> openUsageSettings() async {
    await _channel.invokeMethod('openUsageSettings');
    
  }

  // Check Location permission
  static Future<bool> isLocationPermissionGranted() async {
    final status = await Permission.location.status;
    return status == PermissionStatus.granted;
  }

  // Request Location permission
  static Future<bool> requestLocationPermission() async {
    final result = await Permission.location.request();
    return result == PermissionStatus.granted;
  }
}
