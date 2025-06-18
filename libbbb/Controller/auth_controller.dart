import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frido_app/Global/global.dart';
import 'package:frido_app/View/BottomNavigationBar/Home/home_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;



Future isCurrentUser()async{
  final user = await _auth.currentUser;
  if(user != null){
    return true;
  }else{
    return false;
  }
}


  Future signUp({
    required String name,
    required String email,
    // required String password,
  }) async {
    myLoadingDialog(Get.context!);
    await _auth
        .createUserWithEmailAndPassword(email: email, password: "12345678")
        .then((value) {
          Get.back();
          update();
          mySuccessSnackBar(
            context: Get.context!,
            message: "Account Created Successfully!",
          );
        })
        .catchError((error) {
          Get.back();
          update();
          myErrorSnackBar(context: Get.context!, message: error.toString());
        });
  }

  Future login({required String email, required String password}) async {
    myLoadingDialog(Get.context!);
    // await _auth
    //     .signInWithEmailAndPassword(email: email, password: password)
    //     .then((value) {
    //       Get.back();
    //       update();
    //       mySuccessSnackBar(
    //         context: Get.context!,
    //         message: "Login Successfully!",
    //       );
    //     })
    //     .catchError((error) {
    //       Get.back();
    //       update();
    //       myErrorSnackBar(context: Get.context!, message: error.toString());
    //     });
    Get.offAll(()=> HomeView());
  }
}
