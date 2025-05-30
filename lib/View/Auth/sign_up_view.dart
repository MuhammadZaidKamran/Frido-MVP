// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:frido_app/Controller/auth_controller.dart';
// import 'package:frido_app/Global/colors.dart';
// import 'package:frido_app/Global/global.dart';
// import 'package:frido_app/View/Auth/login_view.dart';
// import 'package:frido_app/View/Auth/otp_verification_view.dart';
// import 'package:frido_app/Widgets/my_button.dart';
// import 'package:frido_app/Widgets/my_text_field.dart';
// import 'package:get/get.dart';

// class SignUpView extends StatefulWidget {
//   const SignUpView({super.key});

//   @override
//   State<SignUpView> createState() => _SignUpViewState();
// }

// class _SignUpViewState extends State<SignUpView> {
// //
//   final _toController = TextEditingController();
//   final _subjectController = TextEditingController();
//   final _messageController = TextEditingController();
//   bool _loading = false;
//   String _status = '';

//   Future<void> sendEmail() async {
//     setState(() {
//       _loading = true;
//       _status = '';
//       _toController.text = 'mubashirmjjawed@gmail.com';
//       _subjectController.text = 'your otp code ';
//       _messageController.text = 'your otp code is 909090';
//     });

//     try {
//       final callable = FirebaseFunctions.instance.httpsCallable('sendEmail');
//       final result = await callable.call(<String, dynamic>{
//         'to': _toController.text,
//         'subject': _subjectController.text,
//         'message': _messageController.text,
//       });

//       if (result.data['success'] == true) {
//         setState(() {
//           _status = 'Email sent successfully!';
//         });
//       } else {
//         setState(() {
//           _status = 'Failed to send email: ${result.data['error']}';
//           print('/////////////////////////////////////////////// $_status');
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _status = 'Error: $e';
//         print('/////////////////////////////////////////////// $_status');
//       });
//     }

//     setState(() {
//       _loading = false;
//     });
//   }

//   @override
//   void dispose() {
//     _toController.dispose();
//     _subjectController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }
// //

//   final userNameController = TextEditingController();
//   final emailController = TextEditingController();
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
//                       "Quick Signup",
//                       style: TextStyle(fontSize: 30, color: Colors.black),
//                     ),
//                   ),
//                   myHeight(0.06),
//                   Text(
//                     "Full Name",
//                     style: TextStyle(
//                       color: textThemeColor,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 16,
//                     ),
//                   ),
//                   myHeight(0.01),
//                   MyTextField(
//                     controller: userNameController,
//                     label: "Your Name",
//                   ),
//                   myHeight(0.02),
//                   Text(
//                     "Email Address",
//                     style: TextStyle(
//                       color: textThemeColor,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 16,
//                     ),
//                   ),
//                   myHeight(0.01),
//                   MyTextField(controller: emailController, label: "Your Email"),
//                   myHeight(0.02),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
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
//                       SizedBox(
//                         width: Get.width * 0.7,
//                         // height: 50,
//                         child: const Text(
//                           'By creating an account  i accept Frido terms of use and  privacy policy ',
//                           textAlign: TextAlign.start,
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       ),
//                     ],
//                   ),
//                   myHeight(0.025),
//                   // Text('$_status'),
//                   myHeight(0.025),
//                   MyButton(
//                     onTap: () async {
//                       sendEmail();
//                       // Get.to(() => OtpVerificationView());
//                       // await controller
//                       //     .signUp(
//                       //       name: userNameController.text.trim(),
//                       //       email: emailController.text.trim(),
//                       //     )
//                       //     .then((value) {
//                       //       userNameController.clear();
//                       //       emailController.clear();
//                       //     });
//                     },
//                     label: "Sign Up",
//                     isLoading: _loading,
//                   ),
//                   myHeight(0.04),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Already have an account? ",style:TextStyle(fontSize: 12) ,),
//                       myWidth(0.01),
//                       InkWell(
//                         onTap: () {
//                           Get.to(() => LoginView());
//                         },
//                         child: Text(
//                           "Sign In here",
//                           style: TextStyle(
//                             color: mainThemeColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12
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




import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();
  final otpController = TextEditingController();

  String? _generatedOtp;
  String _status = '';

  Future<void> sendOtp() async {
    // Generate random 6-digit OTP
    final otp = (Random().nextInt(900000) + 100000).toString();
    setState(() {
      _generatedOtp = otp;
    });

    final url = Uri.parse('https://us-central1-frido-11d62.cloudfunctions.net/sendEmail');

    final body = {
      'to': emailController.text,
      'subject': 'Your OTP Code',
      'message': 'Your OTP code is $otp',
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        setState(() => _status = 'OTP sent to ${emailController.text}');
        // store otp in local storage
        // navigate to verification screen
              print('///////////////////////$_status');

      } else {
        setState(() => _status = 'Failed: ${response.body}');
              print('///////////////////////$_status');

      }
    } catch (e) {
      setState(() => _status = 'Error: $e');
      print('///////////////////////$_status');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Email OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            SizedBox(height: 10),
            ElevatedButton(onPressed: sendOtp, child: Text('Send OTP')),
            SizedBox(height: 20),
           
          
          ],
        ),
      ),
    );
  }
}
