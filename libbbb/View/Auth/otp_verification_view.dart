import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frido_app/Controller/permission_controllers.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/Global/global.dart';
import 'package:frido_app/View/Home/home_view.dart';
import 'package:frido_app/View/PermissionView/location_permission_screen.dart';
import 'package:frido_app/View/PermissionView/usage_permission_screen.dart';
import 'package:frido_app/Widgets/my_button.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({super.key});

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final pinField01 = TextEditingController();
  final pinField02 = TextEditingController();
  final pinField03 = TextEditingController();
  final pinField04 = TextEditingController();
  final pinField05 = TextEditingController();
  final pinField06 = TextEditingController();
bool usagePermission = false;
bool locationPermission = false;
@override
  void initState() {
    // TODO: implement initState
    checkInitStats();
    super.initState();
  }
void checkInitStats() async {
    

    usagePermission =
        await PermissionControllers.isUsagePermissionGranted();
     locationPermission =
        await PermissionControllers.isLocationPermissionGranted();
    print('location perm : $locationPermission');
    print('usage perm : $usagePermission');

      Future.delayed(Duration(seconds: 3), () {
      

        if (!usagePermission) {
          Get.off(() => UsagePermissionScreen());
          return;
        }

        if (!locationPermission) {
          Get.off(() => LocationPermissionScreen());
          return;
        }

        if(locationPermission && usagePermission){
          Get.off(() => HomeView());
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: myPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myHeight(0.1),
            Text(
              "Please verify your email address",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: textThemeColor,
              ),
            ),
            myHeight(0.01),
            Text(
              "We sent an email to becca@gmail.com, please enter the code below",
              style: TextStyle(fontSize: 13),
            ),
            myHeight(0.04),
            Text(
              "Enter Code",
              style: TextStyle(
                color: textThemeColor,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            myHeight(0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PinTextField(
                  width: Get.width * 0.1,
                  label: "--",
                  controller: pinField01,
                ),
                PinTextField(
                  width: Get.width * 0.1,
                  label: "--",
                  controller: pinField02,
                ),
                PinTextField(
                  width: Get.width * 0.1,
                  label: "--",
                  controller: pinField03,
                ),
                PinTextField(
                  width: Get.width * 0.1,
                  label: "--",
                  controller: pinField04,
                ),
                PinTextField(
                  width: Get.width * 0.1,
                  label: "--",
                  controller: pinField05,
                ),
                PinTextField(
                  width: Get.width * 0.1,
                  label: "--",
                  controller: pinField06,
                ),
              ],
            ),
            myHeight(0.04),
            MyButton(
              onTap: () {
                Get.offAll(() => HomeView());
              },
              label: "Create Account",
            ),
            myHeight(0.03),
            Row(
              children: [
                const Text("Didn’t  see your email?"),
                myWidth(0.01),
                InkWell(
                  onTap: () {
                    // Get.to(() => LoginView());
                  },
                  child: Text(
                    "Resend",
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
  }
}

class PinTextField extends StatelessWidget {
  const PinTextField({
    super.key,
    required this.label,
    this.width,
    required this.controller,
  });
  final String label;
  final double? width;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: TextFormField(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        maxLength: 1,
        keyboardType: TextInputType.number,
        cursorColor: mainThemeColor,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(14),
          hintText: label,
          hintStyle: TextStyle(color: blackColor),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: blackColor.withOpacity(0.45)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
