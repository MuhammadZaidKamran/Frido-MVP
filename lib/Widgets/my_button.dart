import 'package:flutter/material.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:get/get.dart';

class MyButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String label;
  final VoidCallback onTap;
  final BorderRadius? borderRadius;
  final bool secondary;
  final bool isLoading;
  final FontWeight? btnFontWeight;
  final Gradient? gradient;
  final Color? textColor;
  final Color? loadingColor;

  const MyButton({
    super.key,
    this.height,
    this.width,
    required this.onTap,
    required this.label,
    this.isLoading = false,
    this.secondary = false,
    this.borderRadius,
    this.btnFontWeight,
    this.gradient,
    this.textColor,
    this.loadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: borderRadius ?? BorderRadius.circular(20),
      child: Container(
        height: height ?? 55,
        width: width ?? Get.width,
        decoration: BoxDecoration(
          gradient: gradient ?? (secondary 
              ? null 
              : LinearGradient(
                  colors: [mainThemeColor, mainThemeColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
          border: Border.all(
            color: secondary ? borderColor : Colors.transparent,
            width: secondary ? 1 : 0,
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          color: gradient == null 
              ? (secondary ? whiteColor : mainThemeColor)
              : null,
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      loadingColor ?? (secondary ? blackColor : whiteColor),
                    ),
                  ),
                )
              : Text(
                  label,
                  style: TextStyle(
                    color: textColor ?? (secondary ? blackColor : whiteColor),
                    fontSize: 16,
                    fontWeight: btnFontWeight ?? FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}