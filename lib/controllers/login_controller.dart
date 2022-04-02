import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:grape_doc/screens/NavBar.dart';

import '../routes/routes.dart';

class LoginController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final password = TextEditingController();

  login() async {
    if (password.text.length >= 6) {
      Get.defaultDialog(
          title: "Logging in...", content: const CircularProgressIndicator());
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        if (user != null) {
          Get.back();
          Get.offAndToNamed(Routes.home);
        }
      } catch (e) {
        Get.back();
        print(e);
        Get.snackbar("Error", "Registration Error: " + e.toString());
      }
    } else {
      Get.snackbar("Error", "Passwords must be at least 6 characters long",
          duration: const Duration(seconds: 5));

    }
  }
}
