import 'package:flutter/material.dart';
import 'package:frido_app/Controller/auth_controller.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/Global/global.dart';
import 'package:frido_app/Widgets/my_button.dart';
import 'package:frido_app/Widgets/my_text_field.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
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
                children: [
                  myHeight(0.15),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                  myHeight(0.06),
                  MyTextField(controller: emailController, label: "Email"),
                  myHeight(0.02),
                  MyTextField(
                    controller: passwordController,
                    label: "Password",
                  ),
                  myHeight(0.06),
                  MyButton(
                    onTap: () async {
                      await controller
                          .login(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          )
                          .then((value) {
                            emailController.clear();
                            passwordController.clear();
                          });
                    },
                    label: "Login",
                  ),
                  myHeight(0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      myWidth(0.01),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(
                          "Sign Up",
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
