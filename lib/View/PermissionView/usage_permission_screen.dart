import 'package:flutter/material.dart';
import 'package:frido_app/Controller/permission_controllers.dart';
import 'package:frido_app/View/PermissionView/location_permission_screen.dart';
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Usage Permission'),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                PermissionControllers.openUsageSettings();
              },
              child: Container(
                color: Colors.deepPurpleAccent,
                padding: EdgeInsets.all(20),
                child: Text('Give Permission', style: TextStyle(fontSize: 20,color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
