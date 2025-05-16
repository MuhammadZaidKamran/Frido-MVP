import 'package:flutter/material.dart';
import 'package:frido_app/Controller/auth_controller.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/Global/global.dart';
import 'package:frido_app/View/Auth/login_view.dart';
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
                    "Signup",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                  myHeight(0.06),
                  MyTextField(controller: userNameController, label: "Name"),
                  myHeight(0.02),
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
                          .signUp(
                            name: userNameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          )
                          .then((value) {
                            userNameController.clear();
                            emailController.clear();
                            passwordController.clear();
                          });
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
                          "Login",
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
