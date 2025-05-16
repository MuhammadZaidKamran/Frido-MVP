// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:task_management_app/Controllers/add_task_controller.dart';
// import 'package:task_management_app/Global/colors.dart';
// import 'package:task_management_app/Global/global.dart';
// import 'package:task_management_app/Widgets/my_button.dart';

// class AddListDialog extends StatefulWidget {
//   const AddListDialog({super.key});

//   @override
//   State<AddListDialog> createState() => _AddListDialogState();
// }

// class _AddListDialogState extends State<AddListDialog> {
//   final taskListNameController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final addTaskListController = Get.put(TaskController());
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child:
//           //  Obx(
//           //   () =>
//           GetBuilder<TaskController>(builder: (controller) {
//         return Dialog(
//           backgroundColor: isSwitched.value ? blackColor : whiteColor,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           child: Padding(
//             padding: myPadding,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Add New List",
//                       style: TextStyle(
//                         fontSize: 20,
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => Get.back(),
//                       child: const Icon(CupertinoIcons.clear),
//                     ),
//                   ],
//                 ),
//                 myHeight(0.03),
//                 TextFormField(
//                   controller: taskListNameController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     hintText: "List Name",
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please enter a list name";
//                     }
//                     return null;
//                   },
//                 ),
//                 myHeight(0.02),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     MyButton(
//                       secondary: true,
//                       width: Get.width * 0.33,
//                       onTap: () {
//                         Get.back();
//                       },
//                       label: "Cancel",
//                     ),
//                     MyButton(
//                       width: Get.width * 0.33,
//                       onTap: () {
//                         if (_formKey.currentState!.validate()) {
//                           controller.addTaskList(
//                               taskListName: taskListNameController.text.trim());
//                         }
//                       },
//                       label: "Add",
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//     // ),
//     // child: Dialog(
//     //                           backgroundColor:
//     //                               isSwitched.value ? blackColor : whiteColor,
//     //                           shape: RoundedRectangleBorder(
//     //                               borderRadius: BorderRadius.circular(15)),
//     //                           child: Padding(
//     //                             padding: myPadding,
//     //                             child: Column(
//     //                               crossAxisAlignment: CrossAxisAlignment.start,
//     //                               mainAxisSize: MainAxisSize.min,
//     //                               children: [
//     //                                 Row(
//     //                                   mainAxisAlignment:
//     //                                       MainAxisAlignment.spaceBetween,
//     //                                   children: [
//     //                                     const Text(
//     //                                       "Add New List",
//     //                                       style: TextStyle(
//     //                                         fontSize: 20,
//     //                                       ),
//     //                                     ),
//     //                                     InkWell(
//     //                                       onTap: () => Get.back(),
//     //                                       child:
//     //                                           const Icon(CupertinoIcons.clear),
//     //                                     ),
//     //                                   ],
//     //                                 ),
//     //                                 myHeight(0.03),
//     //                                 TextFormField(
//     //                                   controller: ,
//     //                                   decoration: InputDecoration(
//     //                                     border: OutlineInputBorder(
//     //                                         borderRadius:
//     //                                             BorderRadius.circular(10)),
//     //                                     focusedBorder: OutlineInputBorder(
//     //                                         borderRadius:
//     //                                             BorderRadius.circular(10)),
//     //                                     hintText: "List Name",
//     //                                   ),
//     //                                 ),
//     //                                 myHeight(0.02),
//     //                                 Row(
//     //                                   mainAxisAlignment:
//     //                                       MainAxisAlignment.spaceBetween,
//     //                                   children: [
//     //                                     MyButton(
//     //                                       secondary: true,
//     //                                       width: Get.width * 0.33,
//     //                                       onTap: () {
//     //                                         Get.back();
//     //                                       },
//     //                                       label: "Cancel",
//     //                                     ),
//     //                                     MyButton(
//     //                                       width: Get.width * 0.33,
//     //                                       onTap: () {},
//     //                                       label: "Add",
//     //                                     ),
//     //                                   ],
//     //                                 ),
//     //                               ],
//     //                             ),
//     //                           ),
//     //                         ),
//     // );
//   }
// }
