import 'package:flutter/material.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyAppBar(
      {super.key,
      required this.title,
      required this.onTap,
      this.onDrawer = false});
  final String title;
  final VoidCallback onTap;
  bool? onDrawer = false;

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppBar(
        backgroundColor: mainThemeColor,
        leading: InkWell(
          onTap: widget.onTap,
          child: widget.onDrawer == true
              ? Icon(
                  Icons.menu,
                  color: whiteColor,
                )
              : Image.asset(
                  "assets/images/arrowleft.png",
                  color: whiteColor,
                  scale: 2.5,
                ),
        ),
        automaticallyImplyLeading: false,
        title: Text(widget.title.toString()),
        centerTitle: true,
      );
    });
  }
}
