import 'package:flutter/material.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/View/OnboardingView/onboarding_view.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Get.off(() => OnboardingScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Logo",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: blackColor,
          ),
        ),
      ),
    );
  }
}
