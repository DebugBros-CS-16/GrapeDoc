import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grape_doc/SignInProvider.dart';
import 'package:grape_doc/screens/testCamera.dart';
import 'package:grape_doc/screens/testImagePicker.dart';
import 'package:grape_doc/screens/testML.dart';
import 'package:grape_doc/widgets/Navigation_drawer_widget.dart';
import 'package:provider/provider.dart';

import 'BlogScreen.dart';
import 'CameraScreen.dart';
import 'ChatScreen.dart';
import 'HomeScreen.dart';
import 'SignupScreen.dart';

class NavBar extends StatefulWidget {
   NavBar({Key? key}) : super(key: key);

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int _currentIndex = 1;


  void _tabNavigator(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    //CameraScreen(),
    //TestCamera(),
    //TestML(),
    TestImagePicker(),
    const HomeScreen(),
    const ChatScreen(),
    const BlogScreen()
  ];



  Text text = const Text(
    "Welcome",
    style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 28.0
    ),
  );


  _NavBarState() {
    Future.delayed(
        const Duration(seconds: 3),
            () =>
            setState(() {
              text =const Text(
                'Grape Doc',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0
                ),
              );
            })
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        // leading: const IconButton(
        //   icon: Icon(Icons.menu),
        //   tooltip: 'Navigation menu',
        //   onPressed: null,
        // ),
        title: text,
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
              onPressed:(){
                final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              icon: const Icon(Icons.power_settings_new)
          ),
        ],
      ),
      body: _pages[
        _currentIndex
      ],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        showSelectedLabels: false,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: false,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.web),
              label: 'Blog'
          ),
        ],
        onTap: (index) {
          _tabNavigator(index);
        },
      ),
    );
  }
}
