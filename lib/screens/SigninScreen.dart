import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grape_doc/GoogleSignInProvider.dart';
import 'package:provider/provider.dart';
import 'HomeScreen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'NavBar.dart';
import 'SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool hide = true;

  @override
  void initState() {
    var provider =  Provider.of<GoogleSignInProvider>(context, listen: false);
    provider.currentUser.listen((fbUser) {
      if (fbUser != null){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NavBar())
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: Consumer(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: () {  }, icon: Icon(null),),
              title: const Text('Grape Doc',
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 28.0),
              ),
              centerTitle: true,
              backgroundColor: Colors.deepPurple,
            ),
            backgroundColor: Colors.deepPurple,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 400),
                    width: double.infinity,
                    height: 450,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40))),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    margin: const EdgeInsets.only(top: 200, left: 50, right: 50),
                    width: double.infinity,
                    height: 450,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black38, spreadRadius: 0.1, blurRadius: 5)
                        ]),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
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
                                    ? Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text("Forget?"),
                          ),
                        ),
                        ElevatedButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                padding: const EdgeInsets.symmetric(horizontal: 80)),
                            onPressed: () async{
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => NavBar()));
                            },
                            child: const Text("Login")),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account"),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const RegisterScreen()));
                                },
                                child: const Text("Register?")),
                          ],
                        ),
                        // InkWell(
                        //   onTap: () {},
                        //   child: Container(
                        //     width: double.infinity,
                        //     padding: const EdgeInsets.only(left: 15),
                        //     height: 45,
                        //     decoration: BoxDecoration(
                        //         color: Colors.transparent,
                        //         borderRadius: BorderRadius.circular(10)),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         Image.asset(
                        //           "assets/images/google.png",
                        //           width: 40,
                        //           height: 40,
                        //         ),
                        //         const SizedBox(
                        //           width: 20,
                        //         ),
                        //         const Text(
                        //           "Sing In With Google ",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold, fontSize: 14),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        SignInButton(
                          Buttons.Google,
                          onPressed: () async {
                            final provider =
                                Provider.of<GoogleSignInProvider>(context, listen: false);
                            provider.googleLogin();
                          }
                        ),

                        //

                        SignInButton(
                          Buttons.Facebook,
                          onPressed: () {
                            final provider =  Provider.of<GoogleSignInProvider>(context, listen: false);
                            provider.facebookLogin();
                          },
                        ),

                        // SignInButtonBuilder(
                        //   text: 'Sign in with Email',
                        //   icon: Icons.email,
                        //   onPressed: () {},
                        //   backgroundColor: Colors.blueGrey[700]!,
                        // ),
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
                            "Welcome",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 40),
                          ),
                          Text(
                            "Login access to your account",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 17),
                          )
                        ],
                      )),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}