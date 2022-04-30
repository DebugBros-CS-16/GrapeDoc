import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';

@visibleForTesting
class matchPw {
  var password = TextEditingController();
  var passwordretype = TextEditingController();
  var message;

  passwordMatch(TextEditingController password, TextEditingController passwordretype) {
    if (password.text == passwordretype.text) {
      message = "Passwords match";
      return "Passwords match";
    }else{
      message = "Passwords does not match";
      return "Passwords does not match";
    }
  }
}

class pwLength{
  var password = TextEditingController();
  var email = TextEditingController();
  var messageTest;

  validLength(TextEditingController passwordTest, TextEditingController emailTest){
    if (password.text.length >= 6 && email.text.isNotEmpty){
      messageTest = "valid password";
      return "valid password";
    }else{
      messageTest = "Passwords must be at least 6 characters long & Email cannot be empty";
      return "Passwords must be at least 6 characters long & Email cannot be empty";
    }
  }
}

// class MyApp extends StatelessWidget {
//   final matchPw pwMatch = new matchPw();
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(
//       // Hide the debug banner
//       debugShowCheckedModeBanner: false,
//       title: "Kindacode.com",
//       home:  pwMatch.passwordMatch()
//     );
//   }
// }


class RegisterController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final password = TextEditingController();
  //final username = TextEditingController();
  final passwordretype = TextEditingController();
  var output;

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
          // Get.snackbar("Error", "Registration Error:" + e.toString());
          Get.back();
        }
      } else if(passwordretype.text != password.text){
        output = "Passwords does not match";
        // return "Passwords does not match";
        // final matchPw pwMatch = new matchPw();

        // (BuildContext context) {
        //
        //   // set up the button
        //   Widget okButton = TextButton(
        //     child: Text("OK"),
        //     onPressed: () { },
        //   );
        //
        //   // set up the AlertDialog
        //   AlertDialog alert = AlertDialog(
        //     title: Text("My title"),
        //     content: Text('ssss'),
        //     actions: [
        //       okButton,
        //     ],
        //   );
        //
        //   // show the dialog
        //   showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return alert;
        //     },
        //   );
        // };

        // return CupertinoAlertDialog(
        //   title: Text("Error"),
        //   content: Text(pwMatch.passwordMatch(password, passwordretype)),
        //   insetAnimationDuration: const Duration(seconds: 2),
        //
        // );
        // Get.snackbar("Error", "Passwords don't match");
        // Get.snackbar("Error", pwMatch.passwordMatch(password, passwordretype));
        // unMatchedPw();
      }
    } else {
      if(password.text.length < 6) {
        // return "Passwords must be at least 6 characters long";
        output ="Passwords must be at least 6 characters long";
      }
      if (email.text.isEmpty){
        // return "Email cannot be empty";
        output = "Email cannot be empty";
      }
        // final pwLength valid = new pwLength();

      // return CupertinoAlertDialog(
      //   title: Text("Error"),
      //   content: Text(valid.validLength(password, email)),
      //   insetAnimationDuration: const Duration(seconds: 3),
      // );
      // Get.snackbar("Error", valid.validLength(password, email),
      //     duration: const Duration(seconds: 5));
    }

  }

  // unMatchedPw(){
  //   Get.snackbar("Error", "Passwords don't match");
  //   return true;
  // }
}
