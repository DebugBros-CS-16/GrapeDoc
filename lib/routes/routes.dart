
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:grape_doc/screens/BlogScreen.dart';
import 'package:grape_doc/screens/CaptureScreen.dart';
import 'package:grape_doc/screens/ChatScreen.dart';
import 'package:grape_doc/screens/HomeScreen.dart';
import 'package:grape_doc/screens/LoginScreen.dart';
import 'package:grape_doc/screens/NavBar.dart';
import 'package:grape_doc/screens/RegisterScreen.dart';
import 'package:grape_doc/screens/SettingScreen.dart';

class Routes{
  static final String login = "/LoginScreen";
  static final String register = "/RegisterScreen";
  static final String home = "/HomeScreen";
  static final String blog = "BlogScreen";
  static final String addblog = "/AddBlog";
  static final String chat = "/ChatScreen";
  static final String navbar = "/NavBar";
  static final String imagecapture = "/CaptureScreen";
  static final String setting = "/SettingScreen";

  static final routes =[

    // GetPage(
    //   name: Routes.start,
    //   page: ()=> StartPage(),
    // ),

    GetPage(
      name: Routes.login,
      page: ()=> LoginScreen(),
    ),

    GetPage(
      name: Routes.register,
      page: ()=> RegisterScreen(),
    ),

    GetPage(
      name: Routes.home,
      page: ()=> HomeScreen(),
    ),

    GetPage(
      name: Routes.blog,
      page: ()=> BlogScreen(),
    ),

    GetPage(
      name: Routes.addblog,
      page: ()=> BlogScreen(),
    ),

    GetPage(
      name: Routes.chat,
      page: ()=> ChatScreen(),
    ),

    GetPage(
      name: Routes.navbar,
      page: ()=> NavBar(),
    ),

    GetPage(
      name: Routes.imagecapture,
      page: ()=> CaptureScreen(),
    ),

    GetPage(
      name: Routes.setting,
      page: ()=> SettingScreen(),
    ),

  ];

}