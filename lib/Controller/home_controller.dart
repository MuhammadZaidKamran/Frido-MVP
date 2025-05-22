import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:frido_app/main.dart';

class HomeControllers {
  // void loadApps() async {
  //   List<AppInfo> apps = await InstalledApps.getInstalledApps();
  //   print(
  //     'App: ${apps[3].name}, Package: ${apps[3].packageName} icon ${apps[3].iconBase64}',
  //   );
  // }

  Image imageFromBase64String(String base64String) {
    try {
      final cleaned = base64String.replaceAll(RegExp(r'\s+'), '');
      return Image.memory(base64Decode(cleaned));
    } catch (e) {
      print("Base64 decoding failed: $e");
      print(
        "Invalid Base64 string (preview): ${base64String.substring(0, 100)}...",
      );
      return Image.asset('assets/default_icon.png');
    }
  }

  String formatDurationFromMillis(int millis) {
  Duration duration = Duration(milliseconds: millis);

  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  return '${hours}h ${minutes}m ${seconds}s';
}


  Future<List<Map>> getAppStats(String interval) async {
    List<Map<String, dynamic>> stats = await AppsUsage.getUsageStats(interval);
    stats.sort((a, b) => b['usageTime'].compareTo(a['usageTime']),);
    return stats;
  }
}
