import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frido_app/Controller/permission_controllers.dart';
import 'package:frido_app/View/Home/home_view.dart';
import 'package:frido_app/View/OnboardingView/onboarding_view.dart';
import 'package:frido_app/View/PermissionView/usage_permission_screen.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _auth = FirebaseAuth.instance;

  // void checkUsagePermission() async {
  //   bool isUsagePermissionGranted =
  //       await PermissionControllers.isUsagePermissionGranted();
  //   print('usage permission : $isUsagePermissionGranted');

  //   if (isUsagePermissionGranted) {
  //     Get.off(() => LocationPermissionScreen());
  //   }
  // }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () async {
      bool isLocationPermissionGranted =
          await PermissionControllers.isLocationPermissionGranted();
      bool isUsagePermissionGranted =
          await PermissionControllers.isUsagePermissionGranted();
      if (_auth.currentUser == null) {
        Get.off(() => OnboardingScreen());
      } else if (_auth.currentUser != null) {
        if (isUsagePermissionGranted && isLocationPermissionGranted) {
          Get.offAll(() => Home());
        } else {
          Get.off(() => UsagePermissionScreen());
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Image.asset(
          "assets/images/splash_screen.png",
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
