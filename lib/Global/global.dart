import 'package:flutter/material.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:get/get.dart';

EdgeInsetsGeometry myPadding = const EdgeInsets.all(20);

myHeight(double height) {
  return SizedBox(
    height: Get.height * height,
  );
}

myWidth(double width) {
  return SizedBox(
    width: Get.width * width,
  );
}

// UserModel? userModel;

mySuccessSnackBar({
  required BuildContext context,
  required String message,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: whiteColor,
        ),
      ),
      backgroundColor: greenColor,
    ),
    snackBarAnimationStyle:
        AnimationStyle(duration: const Duration(microseconds: 3)),
  );
}

myErrorSnackBar({
  required BuildContext context,
  required String message,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: whiteColor,
        ),
      ),
      backgroundColor: redColor,
    ),
    snackBarAnimationStyle:
        AnimationStyle(duration: const Duration(seconds: 1)),
  );
}

myLoadingDialog(context, [String? message]) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: whiteColor,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: mainThemeColor,
                ),
                myWidth(0.03),
                Text(
                  message ?? "Please Wait....",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        );
      });
}
