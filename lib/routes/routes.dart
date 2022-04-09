
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:grapedoc_test/main.dart';

import '../screens/LoginScreen.dart';
import '../screens/RegisterScreen.dart';


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
      page: ()=> MyHomePage(title: "Hello World"),
    ),
  ];

}