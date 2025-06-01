// import 'package:flutter/material.dart';
// import 'package:frido_app/Controller/auth_controller.dart';
// import 'package:frido_app/Global/colors.dart';
// import 'package:frido_app/Global/global.dart';
// import 'package:frido_app/View/Auth/otp_verification_view.dart';
// import 'package:frido_app/Widgets/my_button.dart';
// import 'package:frido_app/Widgets/my_text_field.dart';
// import 'package:get/get.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final authController = Get.put(AuthController());
//   bool _isTermsAccepted = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetBuilder<AuthController>(
//         builder: (controller) {
//           return Form(
//             key: _formKey,
//             child: Padding(
//               padding: myPadding,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   myHeight(0.15),
//                   Center(
//                     child: Text(
//                       "Login",
//                       style: TextStyle(fontSize: 35, color: textThemeColor),
//                     ),
//                   ),
//                   myHeight(0.06),
//                   Text(
//                     "Email Address",
//                     style: TextStyle(
//                       color: textThemeColor,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 18,
//                     ),
//                   ),
//                   myHeight(0.01),
//                   MyTextField(controller: emailController, label: "Your Email"),
//                   myHeight(0.04),
//                   Row(
//                     children: [
//                       Checkbox(
//                         activeColor: mainThemeColor,
//                         value: _isTermsAccepted,
//                         onChanged: (bool? value) {
//                           setState(() {
//                             _isTermsAccepted = value ?? false;
//                           });
//                         },
//                       ),
//                       const Text('Keep me signed in'),
//                     ],
//                   ),
//                   myHeight(0.025),
//                   MyButton(
//                     onTap: () async {
//                       Get.to(() => OtpVerificationView());
//                       // await controller
//                       //     .login(
//                       //       email: emailController.text.trim(),
//                       //       password: passwordController.text.trim(),
//                       //     )
//                       //     .then((value) {
//                       //       emailController.clear();
//                       //       passwordController.clear();
//                       //     });
//                     },
//                     label: "Login",
//                   ),
//                   myHeight(0.04),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Don't have an account? "),
//                       myWidth(0.01),
//                       InkWell(
//                         onTap: () {
//                           Get.back();
//                         },
//                         child: Text(
//                           "Sign Up here",
//                           style: TextStyle(
//                             color: mainThemeColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
