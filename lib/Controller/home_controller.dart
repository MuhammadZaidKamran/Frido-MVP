import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:frido_app/Controller/app_usage.dart';

class HomeControllers {
  Image imageFromBase64String(String base64String) {
    try {
      final cleaned = base64String.replaceAll(RegExp(r'\s+'), '');
      return Image.memory(base64Decode(cleaned));
    } catch (e) {
      print("Base64 decoding failed: $e");
      return Image.asset('assets/default_icon.png');
    }
  }

  String formatDurationFromMillis(int millis) {
    Duration duration = Duration(milliseconds: millis);
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  Future<List<Map<String, dynamic>>> getAppStats(String filter) async {
    List<Map<String, dynamic>> stats = await AppsUsage.getUsageStats();
    List<Map<String, dynamic>> filtered = [];

    for (var app in stats) {
      final usageStats = Map<String, dynamic>.from(app['usageStats']);
      final time = usageStats[filter] ?? 0;
      app['filteredUsage'] = time;
      filtered.add(app);
    }

    filtered.sort((a, b) => (b['filteredUsage'] as int).compareTo(a['filteredUsage'] as int));
    return filtered;
  }
}
