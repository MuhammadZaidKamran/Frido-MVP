// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:task_management_app/Global/colors.dart';
// import 'package:task_management_app/Global/global.dart';
// import 'package:task_management_app/Screens/Drawer/settings_view.dart';
// import 'package:task_management_app/Widgets/DrawerListTile/drawer_list_tile.dart';
// import 'package:task_management_app/Widgets/MyDrawer/add_list_dialog.dart';

// class MyDrawer extends StatefulWidget {
//   const MyDrawer({super.key});

//   @override
//   State<MyDrawer> createState() => _MyDrawerState();
// }

// class _MyDrawerState extends State<MyDrawer> {
//   String? name;
//   String? email;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Drawer(
//         backgroundColor: isSwitched.value ? blackColor : whiteColor,
//         width: Get.width * 0.7,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 60, 10, 20),
//                 decoration: BoxDecoration(color: mainTheme.value),
//                 child: Row(
//                   children: [
//                     ClipOval(
//                       child: Icon(
//                         CupertinoIcons.person_alt_circle,
//                         color: whiteColor,
//                         size: 80,
//                       ),
//                     ),
//                     myWidth(0.02),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: Get.width * 0.2,
//                           child: Text(
//                             "${userModel?.userName}",
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                                 color: whiteColor),
//                           ),
//                         ),
//                         myHeight(0.007),
//                         SizedBox(
//                           width: Get.width * 0.4,
//                           child: Text(
//                             "${userModel?.email}",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: whiteColor,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               myHeight(0.02),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: DrawerListTile(
//                     title: "Add New List",
//                     icon: Icons.add,
//                     onTap: () {
//                       Get.back();
//                       showDialog(
//                           context: context,
//                           builder: (context) {
//                             return const AddListDialog();
//                           });
//                     }),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: DrawerListTile(
//                     title: "Settings",
//                     icon: CupertinoIcons.settings,
//                     onTap: () {
//                       Get.back();
//                       Get.to(() => const SettingsView());
//                     }),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: DrawerListTile(
//                     title: "Progress",
//                     icon: Icons.bar_chart_rounded,
//                     onTap: () {}),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
