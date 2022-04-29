import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CaptureScreen.dart';
import 'package:grapedoc_test/widgets/Navigation_drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:grapedoc_test/providers/SignInProvider.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'BlogScreen.dart';
import 'ChatScreen.dart';
import 'HomeScreen.dart';
import 'RegisterScreen.dart';

StreamController<int> streamController = StreamController.broadcast();

class NavBar extends StatefulWidget {
  NavBar(this.index,this.stream);
  final int index;
  final Stream<int> stream;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.stream.listen((index) {
     setState(() {
       _currentIndex = index;
     });
    });
  }

  void tabNavigator(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final int index = 1;
  //final Stream<int> stream;

  static final List<Widget> _pages = <Widget>[
    //CameraScreen(),
    //TestCamera(),
    //TestML(),
    CaptureScreen(),
    HomeScreen(),
    const ChatScreen(),
    const BlogScreen()
  ];

  Text text = const Text(
    "Welcome",
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
  );

  _NavBarState() {
    Future.delayed(
        const Duration(seconds: 5),
        () => setState(() {
              text = const Text(
                'Grape Doc',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
              );
            }));
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                final provider =
                Provider.of<SignInProvider>(context, listen: false);
                provider.logout();
              },
              icon: const Icon(Icons.power_settings_new)),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar:
      BottomNavyBar(backgroundColor: Colors.black,
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 5,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.camera_alt_rounded),
            title: Text('Scan'),
            inactiveColor: Colors.white38,
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            inactiveColor: Colors.white38,
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.chat),
            title: Text('ChatBot',),
            inactiveColor: Colors.white38,
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.web),
            title: Text('Blog'),
            inactiveColor: Colors.white38,
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      // BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: _currentIndex,
      //   selectedItemColor: Colors.green,
      //   showSelectedLabels: false,
      //   unselectedItemColor: Colors.white,
      //   showUnselectedLabels: false,
      //   backgroundColor: Colors.black,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.camera_alt_rounded),
      //       label: 'Camera',
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
      //     BottomNavigationBarItem(icon: Icon(Icons.web), label: 'Blog'),
      //   ],
      //   onTap: (index) {
      //     tabNavigator(index);
      //   },
      // ),
    );
  }
}
