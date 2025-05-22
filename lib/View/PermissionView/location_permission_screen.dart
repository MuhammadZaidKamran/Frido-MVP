import 'package:flutter/material.dart';
import 'package:frido_app/Controller/permission_controllers.dart';
import 'package:frido_app/View/Home/home_view.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  State<LocationPermissionScreen> createState() => _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {


 void checkLocationPermission()async {
  bool isLocationPermissionGranted = await PermissionControllers.isLocationPermissionGranted();
  print('location permission : $isLocationPermissionGranted');
   if(isLocationPermissionGranted){
    Get.off(()=>Home());
   }
}

@override
  void initState() {
    // TODO: implement initState
    checkLocationPermission();
    super.initState();
  }


   Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('location Permission'),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                PermissionControllers.requestLocationPermission();
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