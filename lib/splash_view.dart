import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frido_app/Controller/auth_controller.dart';
import 'package:frido_app/Controller/permission_controllers.dart';
import 'package:frido_app/View/BottomNavigationBar/Promotions/save_ad_view_data.dart';
import 'package:frido_app/View/BottomNavigationBar/Promotions/save_promo_data_view.dart';
import 'package:frido_app/View/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:frido_app/View/BottomNavigationBar/Home/home_view.dart';
import 'package:frido_app/View/OnboardingView/onboarding_view.dart';
import 'package:frido_app/View/PermissionView/location_permission_screen.dart';
import 'package:frido_app/View/PermissionView/usage_permission_screen.dart';
import 'package:frido_app/firebase_options.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String uniqueId = prefs.getString('uniqueId') ?? '';
      bool isLocationPermissionGranted =
          await PermissionControllers.isLocationPermissionGranted();
      bool isUsagePermissionGranted =
          await PermissionControllers.isUsagePermissionGranted();
      if (uniqueId == '' || uniqueId.isEmpty) {
        Get.off(() => OnboardingScreen());
      } else if (uniqueId.isNotEmpty || uniqueId != '') {
        if (isUsagePermissionGranted && isLocationPermissionGranted) {
          Get.offAll(() => BottomNavigationBarView());
          // Get.offAll(() => SaveDataView());
          // Get.offAll(() => SaveAdViewData());
        } else {
          Get.off(() => UsagePermissionScreen());
        }
      }
    });
    // checkInitStats();
    super.initState();
  }

  // void checkInitStats() async {

  //   bool usagePermission =
  //       await PermissionControllers.isUsagePermissionGranted();
  //   bool locationPermission =
  //       await PermissionControllers.isLocationPermissionGranted();
  //   bool currentUser = await AuthController().isCurrentUser();
  //   print('location perm : $locationPermission');
  //   print('usage perm : $usagePermission');
  //   print('currentUser : $currentUser');

  //     Future.delayed(Duration(seconds: 3), () {
  //       if (!currentUser) {
  //         Get.off(() => OnboardingScreen());
  //         return;
  //       }

  //       if (!usagePermission) {
  //         Get.off(() => UsagePermissionScreen());
  //         return;
  //       }

  //       if (!locationPermission) {
  //         Get.off(() => LocationPermissionScreen());
  //         return;
  //       }

  //       Get.off(() => HomeView());
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff7F34FF), Color(0xff4C1F99)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Image.asset(
            'assets/images/splash_logo.png',
            width: 200,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}
