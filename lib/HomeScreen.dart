import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BlogScreen.dart';
import 'CameraScreen.dart';
import 'ChatScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            height: 250.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  width: 200.0,
                  color: Colors.purple,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  width: 200.0,
                  color: Colors.green,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  width: 200.0,
                  color: Colors.pink,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  width: 200.0,
                  color: Colors.purple,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  width: 200.0,
                  color: Colors.green,
                ),
                Container(
                  width: 200.0,
                  color: Colors.pink,
                ),
              ],
            ),
          ),
          Container(
            height: 200.0,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            color: Colors.blue,
          ),
          Container(
            height: 200.0,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            color: Colors.red,
          ),
          Container(
            height: 200.0,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            color: Colors.green,
          ),
          Container(
            height: 200.0,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}
