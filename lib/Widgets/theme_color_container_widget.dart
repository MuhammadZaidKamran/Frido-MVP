import 'package:flutter/material.dart';

class ThemeColorContainerWidget extends StatelessWidget {
  const ThemeColorContainerWidget({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
