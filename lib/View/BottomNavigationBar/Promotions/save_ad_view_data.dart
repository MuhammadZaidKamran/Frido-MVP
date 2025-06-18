import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:frido_app/Global/global.dart';
import 'package:frido_app/Widgets/my_button.dart';
import 'package:frido_app/Widgets/my_text_field.dart';
import 'package:get/get.dart';

class SaveAdViewData extends StatefulWidget {
  const SaveAdViewData({super.key});

  @override
  State<SaveAdViewData> createState() => _SaveAdViewDataState();
}

class _SaveAdViewDataState extends State<SaveAdViewData> {
  final _firebaseDatabase = FirebaseDatabase.instance.ref('adView');

  final nameController = TextEditingController();
  // final imageUrlController = TextEditingController();
  final expireAtController = TextEditingController();
  final shortDescriptionController = TextEditingController();
  // final longDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save Ad view data to fire base"),
        centerTitle: true,
      ),
      body: Padding(
        padding: myPadding,
        child: Center(
          child: Column(
            children: [
              myHeight(0.04),
              MyTextField(controller: nameController, label: "Name"),
              myHeight(0.01),
              MyTextField(controller: expireAtController, label: "Expire At"),
              myHeight(0.01),
              MyTextField(
                controller: shortDescriptionController,
                label: "Short Description",
              ),
              myHeight(0.03),
              MyButton(
                onTap: () async {
                  myLoadingDialog(Get.context);
                  DatabaseReference ref = _firebaseDatabase.push();
                  String uniqueKey = ref.key ?? '';
                  await ref
                      .set({
                        'uniqueKey': uniqueKey,
                        'name': nameController.text,
                        'expireAt': expireAtController.text,
                        'shortDescription': shortDescriptionController.text,
                        'createdAt': DateTime.now().toString(),
                        'token': '10',
                        'ad_length': '30',
                      })
                      .then((value) {
                        Get.back();
                        setState(() {});
                        mySuccessSnackBar(
                          context: Get.context!,
                          message: "Successfully Added",
                        );
                      })
                      .catchError((error) {
                        Get.back();
                        setState(() {});
                        myErrorSnackBar(
                          context: Get.context!,
                          message: "Something went wrong $error",
                        );
                      });
                },
                label: "Save",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
