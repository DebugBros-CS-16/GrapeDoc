import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
<<<<<<< HEAD
import 'package:grapedoc_test/routes/routes.dart';
=======
>>>>>>> unit_test
import 'package:grapedoc_test/services/AuthService.dart';
import 'package:grapedoc_test/screens/LoginScreen.dart';

class SignInProvider extends ChangeNotifier {
  final authService = AuthService();
  final FirebaseAuth _auth= FirebaseAuth.instance;

  final googleSignIn = GoogleSignIn();
  // final facebookSignIn = FacebookLogin();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Stream<User?> get currentUser => authService.currentUser;

  BuildContext? get context => null;

  Future googleLogin() async{

    print("LOGGED IN USING GOOGLE");

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await authService.signInWithCredential(credential);

    notifyListeners();

  }

  // facebookLogin() async{
  //   print('Starting Facebook Login');
  //
  //   final res = await facebookSignIn.logIn(
  //     permissions: [
  //       FacebookPermission.publicProfile,
  //       FacebookPermission.email
  //     ]
  //   );
  //
  //   switch(res.status){
  //     case FacebookLoginStatus.success:
  //       print('It Worked');
  //
  //       final FacebookAccessToken? fbToken = res.accessToken;
  //       final credential = FacebookAuthProvider.credential(fbToken!.token);
  //       final result = await authService.signInWithCredential(credential);
  //
  //       print('${result?.user!.displayName} is now logged in');
  //
  //       break;
  //     case FacebookLoginStatus.cancel:
  //       print('The user canceled the login');
  //       break;
  //     case FacebookLoginStatus.error:
  //       print('There was an error');
  //       break;
  //   }
  //
  //   notifyListeners();
  // }

  Future logout() async {
    // await googleSignIn.disconnect().whenComplete(() async{
    //   await _auth.signOut();
    // });
    // await facebookSignIn.logOut();
    FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
<<<<<<< HEAD
=======
    // await facebookSignIn.logOut();
    Navigator.pop(context!, MaterialPageRoute(builder: (context) => const LoginScreen()));
>>>>>>> unit_test
  }
}