import 'package:flutter/material.dart';
import 'package:frido_app/Global/colors.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.prefixIconColor,
    this.maxLines,
    this.maxLength,
    this.fillColor,
    this.hintStyle,
    this.borderRadius,
    this.leading,
    this.height,
    this.width,
    this.trailing,
    this.isAuth = false,
    this.floatingLabel = false,
    this.labelStyle,
    this.borderColor,
    this.focusedBorderColor,
    this.hintText,
  });

  final TextEditingController controller;
  final String label;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Color? prefixIconColor;
  final int? maxLines;
  final int? maxLength;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final BorderRadius? borderRadius;
  final Widget? trailing;
  final Widget? leading;
  final double? height;
  final double? width;
  final bool readOnly;
  final bool obscureText;
  final bool isAuth;
  final bool floatingLabel;
  final TextStyle? labelStyle;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (floatingLabel) ...[
          Text(
            label,
            style: labelStyle ?? TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        SizedBox(
          width: width ?? double.infinity,
          height: height,
          child: TextFormField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            maxLength: maxLength,
            maxLines: maxLines ?? 1,
            onChanged: onChanged,
            validator: validator,
            keyboardType: keyboardType ?? TextInputType.text,
            obscureText: obscureText,
            onTap: onTap,
            cursorColor: mainThemeColor,
            controller: controller,
            readOnly: readOnly,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              suffixIcon: trailing,
              hintMaxLines: 1,
              prefixIcon: prefixIcon,
              prefixIconColor: prefixIconColor,
              filled: true,
              fillColor: fillColor ?? whiteColor,
              hintText: floatingLabel ? hintText ?? label : label,
              hintStyle: hintStyle ?? TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
              floatingLabelBehavior: floatingLabel 
                  ? FloatingLabelBehavior.never 
                  : FloatingLabelBehavior.auto,
              label: floatingLabel ? null : Text(label),
              labelStyle: labelStyle,
              border: isAuth
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor! ?? borderColor!,
                      ),
                    )
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor! ?? borderColor!,
                      ),
                      borderRadius: borderRadius ?? BorderRadius.circular(12),
                    ),
              focusedBorder: isAuth
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: focusedBorderColor ?? mainThemeColor,
                        width: 2,
                      ),
                    )
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                        color: focusedBorderColor ?? mainThemeColor,
                        width: 1.5,
                      ),
                      borderRadius: borderRadius ?? BorderRadius.circular(12),
                    ),
              enabledBorder: isAuth
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor! ?? borderColor!,
                      ),
                    )
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor! ?? borderColor!,
                      ),
                      borderRadius: borderRadius ?? BorderRadius.circular(12),
                    ),
              errorBorder: isAuth
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red[400]!,
                      ),
                    )
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red[400]!,
                      ),
                      borderRadius: borderRadius ?? BorderRadius.circular(12),
                    ),
              focusedErrorBorder: isAuth
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red[400]!,
                        width: 2,
                      ),
                    )
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red[400]!,
                        width: 1.5,
                      ),
                      borderRadius: borderRadius ?? BorderRadius.circular(12),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}