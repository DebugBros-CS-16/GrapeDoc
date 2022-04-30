import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grapedoc_test/controllers/register_controller.dart';
import 'package:grapedoc_test/screens/RegisterScreen.dart';

void main () {

  test("matching passwords" , () {

    TextEditingController password1 = TextEditingController();
    TextEditingController passwordretype1 = TextEditingController();
    password1.text = "xxxxxxx";
    passwordretype1.text = "xxxxxxx";
    final message1 = matchPw();
    message1.passwordMatch(password1, passwordretype1);
    var message2 = "Passwords match";
    expect(message1.message, message2 );

  });

  test("valid password and emailField should not be empty", () {
    TextEditingController passwordTest = TextEditingController();
    TextEditingController emailTest = TextEditingController();
    passwordTest.text = "abc";
    emailTest.text = "";
    final testMessage = pwLength();
    testMessage.validLength(passwordTest,emailTest);
    expect(testMessage.messageTest, "Passwords must be at least 6 characters long & Email cannot be empty");

  });

}