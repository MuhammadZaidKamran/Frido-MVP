import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frido_app/View/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:frido_app/Widgets/my_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frido_app/Controller/permission_controllers.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/Global/global.dart';
import 'package:frido_app/View/PermissionView/location_permission_screen.dart';
import 'package:frido_app/View/PermissionView/usage_permission_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({
    super.key,
    required this.emailController,
    required this.userNameController,
  });
  final TextEditingController emailController;
  final TextEditingController userNameController;

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final List<TextEditingController> _otpControllers = List.generate(
    6, 
    (index) => TextEditingController()
  );
  bool _isLoading = false;
  int _resendTimer = 30;
  bool _canResend = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    _canResend = false;
    _resendTimer = 30;
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_resendTimer == 0) {
        timer.cancel();
        setState(() => _canResend = true);
      } else {
        setState(() => _resendTimer--);
      }
    });
  }

  Future<void> _verifyOtp() async {
    setState(() => _isLoading = true);
    
    final enteredOtp = _otpControllers.map((c) => c.text).join();
    if (enteredOtp.isEmpty || enteredOtp.length < 6) {
      myErrorSnackBar(context: Get.context!, message: "Please enter complete OTP code");
      setState(() => _isLoading = false);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final savedOtp = prefs.getString('otp') ?? '';

    if (enteredOtp == savedOtp) {
      try {
        final uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
        await _firestore.collection('users').doc(uniqueId).set({
          'uniqueId': uniqueId,
          'userName': widget.userNameController.text.trim(),
          'email': widget.emailController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });

        prefs.setString('uniqueId', uniqueId);
        
        final usagePermission = await PermissionControllers.isUsagePermissionGranted();
        final locationPermission = await PermissionControllers.isLocationPermissionGranted();

        setState(() => _isLoading = false);

        if (!usagePermission) {
          Get.offAll(() => const UsagePermissionScreen());
          return;
        }

        if (!locationPermission) {
          PermissionControllers.requestLocationPermission();
          return;
        }

        Get.offAll(() => const BottomNavigationBarView());
        mySuccessSnackBar(
          context: Get.context!,
          message: "Account Created Successfully",
        );
      } catch (error) {
        setState(() => _isLoading = false);
        myErrorSnackBar(context: Get.context!, message: error.toString());
      }
    } else {
      setState(() => _isLoading = false);
      myErrorSnackBar(context: Get.context!, message: "Invalid OTP, please try again");
    }
  }

  Future<void> _resendOtp() async {
    if (!_canResend) return;
    
    setState(() {
      _isLoading = true;
      _canResend = false;
    });

    try {
      final otp = (Random().nextInt(900000) + 100000).toString();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('otp', otp);

      final response = await http.post(
        Uri.parse('https://us-central1-frido-11d62.cloudfunctions.net/sendEmail'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'to': widget.emailController.text,
          'subject': 'Your Frido Verification Code',
          'message': 'Your verification code is: $otp',
        }),
      );

      setState(() => _isLoading = false);
      
      if (response.statusCode == 200) {
        _startResendTimer();
        mySuccessSnackBar(
          context: context,
          message: "New OTP sent to ${widget.emailController.text}",
        );
      } else {
        throw Exception('Failed to send OTP');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _canResend = true;
      });
      myErrorSnackBar(
        context: context,
        message: "Couldn't resend OTP. Please try again.",
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F9FF), Color(0xFFEFF2FF)],
          ),
        ),
        child: Stack(
          children: [
            // Background elements
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      mainThemeColor.withOpacity(0.1),
                      Colors.purple.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

                  // Back button
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: mainThemeColor),
                    onPressed: () => Get.back(),
                  ),

                  const SizedBox(height: 20),

                  // Title
                  Text(
                    "Verify Your Email",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: mainThemeColor,
                      height: 0.9,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Enter the 6-digit code sent to",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.emailController.text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: mainThemeColor,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // OTP Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) => _buildOtpField(index)),
                  ),

                  const SizedBox(height: 40),

                  // Verify Button
                  SizedBox(
                    width: double.infinity,
                    child: MyButton(
                            onTap:(){
                               _isLoading ? null : _verifyOtp();
                            },
                            label: "VERIFY & CONTINUE",
                            isLoading: _isLoading,
                            height: 56,
                            gradient: LinearGradient(
                              colors: [mainThemeColor, Colors.purple[600]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            // labelStyle: const TextStyle(
                            //   fontSize: 15,
                            //   fontWeight: FontWeight.w600,
                            //   letterSpacing: 0.5,
                            // ),
                          ),
                  ),
                   

                  const SizedBox(height: 24),

                  // Resend Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive code?",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: _canResend ? _resendOtp : null,
                        child: _canResend
                            ? Text(
                                "Resend Code",
                                style: TextStyle(
                                  color: mainThemeColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                "Resend in $_resendTimer sec",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 48,
      height: 60,
      child: TextField(
        controller: _otpControllers[index],
        onChanged: (value) {
          if (value.length == 1) {
            if (index < 5) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: mainThemeColor,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: mainThemeColor, width: 2),
          ),
        ),
      ),
    );
  }
}