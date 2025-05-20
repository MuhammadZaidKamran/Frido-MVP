import 'package:flutter/material.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  MyButton({
    super.key,
    this.height,
    this.width,
    required this.onTap,
    required this.label,
    this.isLoading = false,
    this.secondary = false,
    this.borderRadius,
    this.btnFontWeight,
  });
  final double? height;
  final double? width;
  final String label;
  final VoidCallback onTap;
  final BorderRadius? borderRadius;
  bool secondary = false;
  bool isLoading = false;
  final FontWeight? btnFontWeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 55,
        width: width ?? Get.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: secondary == true ? borderColor : Colors.transparent,
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          color: secondary == true ? whiteColor : mainThemeColor,
        ),
        child: Center(
          child:
              isLoading
                  ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: blackColor,
                      valueColor: AlwaysStoppedAnimation<Color>(whiteColor),
                    ),
                  )
                  : Text(
                    label,
                    style: TextStyle(
                      color: secondary == true ? blackColor : whiteColor,
                      fontSize: 16,
                      fontWeight: btnFontWeight ?? FontWeight.w500,
                    ),
                  ),
        ),
      ),
    );
  }
}
