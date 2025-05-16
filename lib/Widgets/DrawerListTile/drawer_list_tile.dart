// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:task_management_app/Global/colors.dart';
// import 'package:task_management_app/Global/global.dart';

// class DrawerListTile extends StatelessWidget {
//   const DrawerListTile(
//       {super.key,
//       required this.title,
//       required this.icon,
//       required this.onTap});
//   final String title;
//   final IconData icon;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: onTap,
//         child: Obx(() {
//           return ListTile(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             tileColor: borderColor.withOpacity(0.15),
//             leading: Icon(
//               icon,
//               size: 25,
//               color: isSwitched.value ? whiteColor : blackColor,
//             ),
//             title: Text(
//               title,
//               style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w500,
//                   color: isSwitched.value ? whiteColor : blackColor),
//             ),
//           );
//         }));
//   }
// }
