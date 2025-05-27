import 'package:flutter/material.dart';
import 'package:frido_app/Controller/permission_controllers.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/Global/global.dart';
import 'package:frido_app/View/PermissionView/location_permission_screen.dart';
import 'package:frido_app/Widgets/my_button.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class UsagePermissionScreen extends StatefulWidget {
  const UsagePermissionScreen({super.key});

  @override
  State<UsagePermissionScreen> createState() => _UsagePermissionScreenState();
}

class _UsagePermissionScreenState extends State<UsagePermissionScreen> {

  void checkUsagePermission()async {
  bool isUsagePermissionGranted = await PermissionControllers.isUsagePermissionGranted();
    print('usage permission : $isUsagePermissionGranted');

   if(isUsagePermissionGranted){
    Get.off(()=>LocationPermissionScreen());
   }
}

@override
  void initState() {
    // TODO: implement initState
    checkUsagePermission();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: myPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myHeight(0.15),
            Center(
              child: Image.asset(
                "assets/images/usage_permission.png",
                fit: BoxFit.cover,
                height: Get.height * 0.35,
              ),
            ),
            myHeight(0.06),
            Text(
              "Screen Time Access",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: textThemeColor,
              ),
            ),
            myHeight(0.02),
            Text(
              "Grant Frido permission to track your screen time.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
            ),
            Spacer(),
            MyButton(
              onTap: () async {
                await PermissionControllers.openUsageSettings().then((value) {
                  checkUsagePermission();
                });
              },
              label: "Allow Access",
            ),
          ],
        ),
      ),
    );
  }
}
