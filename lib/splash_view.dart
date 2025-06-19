import 'package:frido_app/Controller/permission_controllers.dart';
import 'package:frido_app/View/BottomNavigationBar/Promotions/save_ad_view_data.dart';
import 'package:frido_app/View/BottomNavigationBar/Promotions/save_promo_data_view.dart';
import 'package:frido_app/View/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:frido_app/View/BottomNavigationBar/Home/home_view.dart';
import 'package:frido_app/View/OnboardingView/onboarding_view.dart';
import 'package:frido_app/View/PermissionView/location_permission_screen.dart';
import 'package:frido_app/View/PermissionView/usage_permission_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frido_app/View/BottomNavigationBar/Home/home_view.dart';
import 'package:frido_app/Global/colors.dart'; // Assuming you have this

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Your existing initialization logic
    await Future.delayed(const Duration(seconds: 2)); // Reduced from 3s for better UX
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uniqueId = prefs.getString('uniqueId') ?? '';
    // bool isLocationPermissionGranted = 
    //     await PermissionControllers.isLocationPermissionGranted();
    bool isUsagePermissionGranted = 
        await PermissionControllers.isUsagePermissionGranted();

        // if(!isLocationPermissionGranted){
        //   PermissionControllers.requestLocationPermission();
        // }

    if (uniqueId.isEmpty) {
      Get.off(() => const OnboardingScreen());
    } else {
      if (isUsagePermissionGranted) {
        Get.offAll(() => const BottomNavigationBarView());
      } else {
        Get.off(() => const UsagePermissionScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              mainThemeColor, // Using your app's main theme color
              Colors.purple[600]!, // Matching home view gradient
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background elements that match home view
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'app-logo',
                    child: Image.asset(
                      'assets/images/splash_logo.png',
                      width: 180,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                ],
              ),
            ),
            
            // Version/branding text
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'Frido',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Screen Time Tracker',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}