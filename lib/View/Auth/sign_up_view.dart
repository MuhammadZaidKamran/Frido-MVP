import 'package:flutter/material.dart';
import 'package:frido_app/Controller/auth_controller.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/Global/global.dart';
import 'package:frido_app/View/Auth/login_view.dart';
import 'package:frido_app/View/Auth/otp_verification_view.dart';
import 'package:frido_app/Widgets/my_button.dart';
import 'package:frido_app/Widgets/my_text_field.dart';
import 'package:get/get.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  bool _isTermsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: myPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myHeight(0.15),
                  Center(
                    child: Text(
                      "Signup",
                      style: TextStyle(fontSize: 35, color: textThemeColor),
                    ),
                  ),
                  myHeight(0.06),
                  Text(
                    "Full Name",
                    style: TextStyle(
                      color: textThemeColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  myHeight(0.01),
                  MyTextField(
                    controller: userNameController,
                    label: "Your Name",
                  ),
                  myHeight(0.04),
                  Text(
                    "Email Address",
                    style: TextStyle(
                      color: textThemeColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  myHeight(0.01),
                  MyTextField(controller: emailController, label: "Your Email"),
                  myHeight(0.04),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: mainThemeColor,
                        value: _isTermsAccepted,
                        onChanged: (bool? value) {
                          setState(() {
                            _isTermsAccepted = value ?? false;
                          });
                        },
                      ),
                      SizedBox(
                        width: Get.width * 0.7,
                        height: 50,
                        child: const Text(
                          'By creating an account  i accept Frido terms of use and  privacy policy ',
                        ),
                      ),
                    ],
                  ),
                  myHeight(0.025),
                  MyButton(
                    onTap: () async {
                      Get.to(() => OtpVerificationView());
                      // await controller
                      //     .signUp(
                      //       name: userNameController.text.trim(),
                      //       email: emailController.text.trim(),
                      //     )
                      //     .then((value) {
                      //       userNameController.clear();
                      //       emailController.clear();
                      //     });
                    },
                    label: "Sign Up",
                  ),
                  myHeight(0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      myWidth(0.01),
                      InkWell(
                        onTap: () {
                          Get.to(() => LoginView());
                        },
                        child: Text(
                          "Sign In here",
                          style: TextStyle(
                            color: mainThemeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
