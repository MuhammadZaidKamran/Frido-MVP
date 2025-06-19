// import 'package:flutter/material.dart';
// import 'package:frido_app/Controller/permission_controllers.dart';
// import 'package:frido_app/Global/colors.dart';
// import 'package:frido_app/Global/global.dart';
// import 'package:frido_app/View/BottomNavigationBar/Home/home_view.dart';
// import 'package:frido_app/Widgets/my_button.dart';
// import 'package:get/get.dart';
// import 'package:get/utils.dart';

// class LocationPermissionScreen extends StatefulWidget {
//   const LocationPermissionScreen({super.key});

//   @override
//   State<LocationPermissionScreen> createState() =>
//       _LocationPermissionScreenState();
// }

// class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
//   void checkLocationPermission() async {
//     bool isLocationPermissionGranted =
//         await PermissionControllers.isLocationPermissionGranted();
//     print('location permission : $isLocationPermissionGranted');
//     if (isLocationPermissionGranted) {
//       Get.off(() => HomeView());
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     checkLocationPermission();
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: myPadding,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             myHeight(0.15),
//             Center(
//               child: Image.asset(
//                 "assets/images/location_permission.png",
//                 fit: BoxFit.cover,
//                 height: Get.height * 0.35,
//               ),
//             ),
//             myHeight(0.06),
//             Text(
//               "Allow Location Access",
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.w500,
//                 color: textThemeColor,
//               ),
//             ),
//             myHeight(0.02),
//             Text(
//               "Grant Frido permission to track your location.",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
//             ),
//             Spacer(),
//             MyButton(
//               onTap: () async {
//                 await PermissionControllers.requestLocationPermission().then((
//                   value,
//                 ) {
//                   checkLocationPermission();
//                 });
//               },
//               label: "Allow Access",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
