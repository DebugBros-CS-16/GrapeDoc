import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grape_doc/GoogleSignInProvider.dart';
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

  static List<Widget> _pages = <Widget>[
    CameraScreen(),
    HomeScreen(),
    ChatScreen(),
    BlogScreen()
  ];


  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text(
          'Grape Doc',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28.0
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
              onPressed:(){
                final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              icon: const Icon(Icons.logout)
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
