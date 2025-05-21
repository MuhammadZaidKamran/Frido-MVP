// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// <<<<<<< Updated upstream
// import 'package:flutter/services.dart';
// =======
// import 'package:frido_app/Global/colors.dart';
// >>>>>>> Stashed changes
// import 'package:frido_app/View/Home/home_view.dart';
// import 'package:frido_app/firebase_options.dart';
// import 'package:frido_app/splash_view.dart';
// import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/View/Home/home_view.dart';
import 'package:frido_app/firebase_options.dart';
import 'package:frido_app/splash_view.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'frido-app',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: whiteColor,fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      title: "Frido App",
      home: Home(),
    );
  }
}


class AppInfo {
  final String name;
  final String packageName;
  final String iconBase64;

  AppInfo({required this.name, required this.packageName, required this.iconBase64});

  factory AppInfo.fromMap(Map<dynamic, dynamic> map) {
    return AppInfo(
      name: map['name'],
      packageName: map['packageName'],
      iconBase64: map['iconBase64'],
    );
  }
}

class InstalledApps {
  static const MethodChannel _channel = MethodChannel('com.example.app/installed_apps');

  static Future<List<AppInfo>> getInstalledApps() async {
    try {
      final List apps = await _channel.invokeMethod('getInstalledApps');
      return apps.map((app) => AppInfo.fromMap(app)).toList();
    } catch (e) {
      print("Error getting apps: $e");
      return [];
    }
  }
}

class AppsUsage {
  static const usageChannel = MethodChannel('com.example.app/usage_stats');

  static Future<List<Map<String, dynamic>>> getUsageStats(String interval) async {
    final List<dynamic> data = await usageChannel.invokeMethod(
      "getUsageStats",
      {"interval": interval},
    );
    return data.map((item) => Map<String, dynamic>.from(item)).toList();
  }
}
