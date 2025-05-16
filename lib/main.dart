import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
      debugShowCheckedModeBanner: false,
      title: "Frido App",
      home: SplashView(),
    );
  }
}
