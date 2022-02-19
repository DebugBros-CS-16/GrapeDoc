import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:grape_doc/Services/AuthService.dart';
import 'package:grape_doc/screens/NavBar.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final authService = AuthService();

  final googleSignIn = GoogleSignIn();
  final facebookSignIn = FacebookLogin();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Stream<User?> get currentUser => authService.currentUser;

  Future googleLogin() async{
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

  facebookLogin() async{
    print('Starting Facebook Login');

    final res = await facebookSignIn.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email
      ]
    );

    switch(res.status){
      case FacebookLoginStatus.success:
        print('It Worked');

        final FacebookAccessToken? fbToken = res.accessToken;
        final credential = FacebookAuthProvider.credential(fbToken!.token);
        final result = await authService.signInWithCredential(credential);

        print('${result?.user!.displayName} is now logged in');

        break;
      case FacebookLoginStatus.cancel:
        print('The user canceled the login');
        break;
      case FacebookLoginStatus.error:
        print('There was an error');
        break;
    }

    notifyListeners();
  }

  Future logout() async {
    //await googleSignIn.disconnect();
    await facebookSignIn.logOut();
    FirebaseAuth.instance.signOut();
  }
}