import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';

class RegisterController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final password = TextEditingController();
  //final username = TextEditingController();
  final passwordretype = TextEditingController();

  registerUser() async {

    if (password.text.length >= 6 && email.text.isNotEmpty) {
      if (passwordretype.text == password.text) {
        // Get.defaultDialog(
        //     barrierDismissible: false,
        //     title: "Registering...", content: const CircularProgressIndicator());
        try {
          final newUser = await _auth.createUserWithEmailAndPassword(
              email: email.text, password: password.text);
          if (newUser.user!.uid!=null) {
            Get.back();
            Get.toNamed(Routes.login);
          }
        } catch (e) {
          print(e);

          Get.snackbar("Error", "Registration Error:" + e.toString());
          Get.back();
        }
      } else {
        Get.snackbar("Error", "Passwords don't match");
      }
    } else {
      Get.snackbar("Error",
          "Passwords must be at least 6 characters long & Username cannot be empty",
          duration: const Duration(seconds: 5));
    }

  }
}
