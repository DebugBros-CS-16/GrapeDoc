import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:grape_doc/GoogleSignInProvider.dart';
import 'package:grape_doc/screens/SettingScreen.dart';
import 'package:provider/provider.dart';

import 'screens/ChatScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/NavBar.dart';
import 'screens/SigninScreen.dart';
import 'screens/SignupScreen.dart';


List<CameraDescription> cameras = [];

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try{
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const MyHomePage(title: 'Hello'),
        //home: const SettingScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              } else if (snapshot.hasData) {
                return NavBar();
              } else if (snapshot.hasError) {
                return Center(child: Text('Something Went Wrong!'),);
              } else {
                return LoginScreen();
              }
            },
          ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('Grape Doc',
          style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 28.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),

      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 70.0,
                ),
                Image.asset("assets/images/grapedoclogo.png"),
                const SizedBox(
                  height: 100.0,
                ),
                const Text(
                  'Instant disease detection and \n farming assistant',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
