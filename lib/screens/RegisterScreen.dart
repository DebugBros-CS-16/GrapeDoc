import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';
import 'LoginScreen.dart';
import 'package:grapedoc_test/controllers/register_controller.dart';


// class matchPw {
//   var password = TextEditingController();
//   var passwordretype = TextEditingController();
//   var message;
//
//   passwordMatch(TextEditingController password, TextEditingController passwordretype) {
//     if (password.text == passwordretype.text) {
//       // message = "Password Match";
//       return "Passwords match";
//     }else{
//       // message = "Password Mismatch";
//       return "Passwords Mismatch";
//     }
//   }
// }
//
// class pwLength{
//   var password = TextEditingController();
//   var email = TextEditingController();
//   var messageTest;
//
//   validLength(TextEditingController emailTest){
//     if (password.text.length >= 6 && email.text.isNotEmpty){
//       messageTest = "valid password";
//     }else{
//       messageTest = "Passwords must be at least 6 characters long & Username cannot be empty";
//     }
//   }
// }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final RegisterController controller = Get.put(RegisterController());
  bool hide = true;
  bool _validate = false;
  final _text = TextEditingController();
  // final RegisterUser = RegisterController();
   matchPw RegisterUser = matchPw();
   pwLength RegisterUser2 = pwLength();
  var displayMessage;
  final UserRegister = RegisterController();




  // late String _email;
  // late String value;
  //
  // final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(null),
        ),
        title: const Text('GrapeDoc',
          style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 28.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.purple,
      body: SingleChildScrollView(
        child: Stack(
          // key: _formkey,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 400),
              width: double.infinity,
              height: 450,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25))),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: const EdgeInsets.only(top: 200, left: 50, right: 50),
              width: double.infinity,
              height: 380,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black38, spreadRadius: 0.1, blurRadius: 5)
                  ]),
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.email,
                    decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                    textInputAction: TextInputAction.next,
                    // validator: (value){
                    //   if(value!.isEmpty){
                    //     return "Email cannot be empty";
                    //   }
                    //   return null;
                    // },
                    // onSaved: (email){
                    //   _email = email!;
                    // },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: controller.password,
                    obscureText: hide,
                    decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hide = !hide;
                            });
                          },
                          icon: hide
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: controller.passwordretype,
                    obscureText: hide,
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hide = !hide;
                            });
                          },
                          icon: hide
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(horizontal: 80)),
                      onPressed: () {
                        print("0000000000");



                        setState(() {
                          // _text.text.isEmpty ? _validate = true : _validate = false;
                          // showInSnackBar("Blog Added successfully");
                          controller.registerUser();

                          // RegisterUser.registerUser();
                          // showInSnackBar("Passwords does not match");
                          print(controller.password.text);
                          print(controller.passwordretype.text);
                          // displayMessage = RegisterUser.message.toString();
                          // print(displayMessage);
                          // if(RegisterUser.password.text != RegisterUser.passwordretype.text) {
                          print(controller.email.text);
                          print(controller.output);
                          if(controller.email.text=="") {
                            showInSnackBar2(controller.output);
                          }else if(controller.password.text != controller.passwordretype.text){
                            showInSnackBar(controller.output);
                          }else if((controller.password.text.length < 6) || (controller.passwordretype.text.length < 6)){
                            showInSnackBar3(controller.output);
                          }
                            // if(RegisterScreen.)
                          // } else{
                          //   showInSnackBar("Passwords does not match");

                        });


                        // if(_formkey.currentState!.validate()){
                        //   return;
                        // }else{
                        //   print("unsuccessfull");
                        // }
                      },
                      // {
                      //   if (controller.password.text != controller.passwordretype.text) {
                      //     showDialog(
                      //         context: context,
                      //         builder: (context) {
                      //           return AlertDialog(
                      //             title: const Text("Message"),
                      //             content: const Text(
                      //                 "Your Enter Password Do Not Match Each Other"),
                      //             actions: [
                      //               TextButton(
                      //                   onPressed: () {
                      //                     Navigator.pop(context);
                      //                   },
                      //                   child: const Text("OK"))
                      //             ],
                      //           );
                      //         });
                      //   } else {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => const LoginScreen()));
                      //   }
                      // },
                      child: const Text("Register")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text("Login"))
                    ],
                  )
                ],
              ),
            ),

            Positioned(
                top: 80,
                left: 55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                    Text(
                      "Create your account",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 17),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void showInSnackBar(String value) {

    // RegisterUser.passwordMatch(controller.password, controller.passwordretype);


    final snackBar = SnackBar(
      // content: const Text("Passwords does not match"),
      // content: Text(controller.output),
      content: Text(RegisterUser.passwordMatch(controller.password,controller.passwordretype)),
      backgroundColor: Colors.red,

      duration: new Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }

  void showInSnackBar2(String value) {
    // final RegisterUser = RegisterController();
    // RegisterUser.registerUser();

    final snackBar2 = SnackBar(
      // content: const Text("Email cannot be empty"),
      // content: Text(controller.output),
      content: Text(RegisterUser2.validLength(controller.password, controller.email)),
      backgroundColor: Colors.red,

      duration: new Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar2);

  }

  void showInSnackBar3(String value) {
    final RegisterUser = RegisterController();
    RegisterUser.registerUser();

    final snackBar3 = SnackBar(
      content: Text(controller.output),
      backgroundColor: Colors.red,

      duration: new Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar3);

  }
}