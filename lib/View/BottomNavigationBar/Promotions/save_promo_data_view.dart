import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:frido_app/Global/global.dart';
import 'package:frido_app/Widgets/my_button.dart';
import 'package:frido_app/Widgets/my_text_field.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class SavePromoDataView extends StatefulWidget {
  const SavePromoDataView({super.key});

  @override
  State<SavePromoDataView> createState() => _SavePromoDataViewState();
}

class _SavePromoDataViewState extends State<SavePromoDataView> {
  final _firebaseDatabase = FirebaseDatabase.instance.ref('promoView');

  final nameController = TextEditingController();
  final imageUrlController = TextEditingController();
  final expireAtController = TextEditingController();
  final shortDescriptionController = TextEditingController();
  final longDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Save data to fire base"), centerTitle: true),
      body: Padding(
        padding: myPadding,
        child: Center(
          child: Column(
            children: [
              myHeight(0.04),
              MyTextField(controller: nameController, label: "Name"),
              myHeight(0.01),
              MyTextField(controller: imageUrlController, label: "Image Url"),
              myHeight(0.01),
              MyTextField(controller: expireAtController, label: "Expire At"),
              myHeight(0.01),
              MyTextField(
                controller: shortDescriptionController,
                label: "Short Description",
              ),
              myHeight(0.01),
              MyTextField(
                controller: longDescriptionController,
                label: "Long Description",
                maxLines: 5,
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
                        'imageUrl': imageUrlController.text,
                        'expireAt': expireAtController.text,
                        'shortDescription': shortDescriptionController.text,
                        'longDescription': longDescriptionController.text,
                        'createdAt': DateTime.now().toString(),
                        'token': {'view': '10', 'link': '50', 'shop': '100'},
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
