import 'package:flutter/services.dart';

class AppsUsage {
  static const usageChannel = MethodChannel('com.example.app/usage_stats');

  static Future<List<Map<String, dynamic>>> getUsageStats() async {
    final List<dynamic> data = await usageChannel.invokeMethod("getUsageStats");
    return data.map((item) => Map<String, dynamic>.from(item)).toList();
  }
}
