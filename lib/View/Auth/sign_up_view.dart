import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/View/Auth/otp_verification_view.dart';
import 'package:frido_app/Widgets/my_button.dart';
import 'package:frido_app/Widgets/my_text_field.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _termsAccepted = false;
  bool _isLoading = false;

  void _handleSignUp() async {
  if (!_formKey.currentState!.validate()) return;
  if (!_termsAccepted) {
    Get.snackbar(
      "Required", 
      "Please accept terms & conditions",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[400],
      colorText: Colors.white,
    );
    return;
  }

  setState(() => _isLoading = true);
  
  try {
    // Generate OTP
    final otp = (Random().nextInt(900000) + 100000).toString();
    final prefs = await SharedPreferences.getInstance();
    
    // Store OTP immediately for verification
    await prefs.setString('otp', otp);

    // Send OTP via email
    final response = await http.post(
      Uri.parse('https://us-central1-frido-11d62.cloudfunctions.net/sendEmail'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'to': _emailController.text,
        'subject': 'Your Frido Verification Code',
        'message': 'Your OTP code is: $otp',
      }),
    );

    if (response.statusCode == 200) {
      Get.to(() => OtpVerificationView(
        emailController: _emailController,
        userNameController: _nameController,
      ));
    } else {
      throw Exception('Failed to send OTP: ${response.statusCode}');
    }
  } catch (e) {
    Get.snackbar(
      "Error",
      "Couldn't send OTP. Please try again.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[400],
      colorText: Colors.white,
    );
    debugPrint('OTP Error: $e');
  } finally {
    setState(() => _isLoading = false);
  }
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
                  const SizedBox(height: 80),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Join Frido",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: mainThemeColor,
                          height: 0.9,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Let's get you started in 30 seconds",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 60),

                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Name Field
                          MyTextField(
                            controller: _nameController,
                            label: "Full Name",
                            // prefixIcon: Icons.person_outline_rounded,
                            floatingLabel: true,
                            labelStyle: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                            borderColor: Colors.grey[200],
                          ),

                          const SizedBox(height: 24),

                          // Email Field
                          MyTextField(
                            controller: _emailController,
                            label: "Email Address",
                            // prefixIcon: Icons.email_outlined,
                            floatingLabel: true,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!GetUtils.isEmail(value)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                            labelStyle: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                            borderColor: Colors.grey[200],
                          ),

                          const SizedBox(height: 24),

                          // Terms Checkbox
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 0.9,
                                child: Checkbox(
                                  value: _termsAccepted,
                                  onChanged: (value) =>
                                      setState(() => _termsAccepted = value ?? false),
                                  activeColor: mainThemeColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                        height: 1.4,
                                      ),
                                      children: [
                                        const TextSpan(text: 'By continuing, I agree to '),
                                        TextSpan(
                                          text: 'Terms of Service',
                                          style: TextStyle(
                                            color: mainThemeColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const TextSpan(text: ' and '),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: TextStyle(
                                            color: mainThemeColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Continue Button
                          MyButton(
                            onTap: _handleSignUp,
                            label: "GET VERIFICATION CODE",
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
                        ],
                      ),
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