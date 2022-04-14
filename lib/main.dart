import 'package:flutter/material.dart';
import 'package:grapedoc_test/screens/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/SignInProvider.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
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
        create: (BuildContext context) => SignInProvider(),
        child: MaterialApp(
          title: 'GrapeDoc',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: const LoginScreen(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
