import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:grapedoc_test/main.dart';
import 'package:grapedoc_test/routes/routes.dart';
import 'package:grapedoc_test/screens/NavBar.dart';



class LoginController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final password = TextEditingController();

  BuildContext? get context => null;

  login(context) async {
    if (password.text.length >= 6) {
      // Get.defaultDialog(
      //     title: "Logging in...", content: const CircularProgressIndicator());
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavBar()),
          );
        }
      } catch (e) {
        Get.back();
        print(e);
        // Get.snackbar("Error", "Registration Error: " + e.toString());
      }
    } else {
      Get.snackbar("Error", "Passwords must be at least 6 characters long",
          duration: const Duration(seconds: 5));

    }
  }
}
