import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskOptionsContainer extends StatelessWidget {
  TaskOptionsContainer(
      {super.key,
      this.width,
      required this.title,
      required this.textColor,
      required this.backgroundColor,
      required this.onTap,
      required this.borderColor});
  double? width;
  final String title;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
