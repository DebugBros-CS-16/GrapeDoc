import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: null,
              padding: const EdgeInsets.only(right: 20.0),
              icon: const Icon(
                Icons.info_sharp,
                color: Colors.white,
              )),
        ],
      ),
      body: ListView(
        children: [
          Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              padding: const EdgeInsets.all(20.0),
              decoration: (BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              )),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'GrapeDoc',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 35.0,
                        fontFamily: 'Salsa',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/images/grapedoclogo.png",
                      height: 200.0,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'GrapeDoc is a mobile application that assists farmers in detecting grape leaf diseases and increasing their revenues through improved insights. Users can get answers to their questions quickly and easily. GrapeDoc ensures consistency and brings everything closer together.',
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )),
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            padding: const EdgeInsets.all(20.0),
            decoration: (BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            )),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Developed by',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Team Debugbros - CS-16',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'grapedocdev@gmail.com',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blueAccent,
                        size: 30.0,
                      ),
                      Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.pink,
                        size: 30.0,
                      ),
                      Icon(
                        FontAwesomeIcons.twitter,
                        color: Colors.lightBlue,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              ' Copyright ©2021-2022 Team Debugbros Development\nAll Rights Reserved.',
              style: TextStyle(
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      ),
    );
  }
}
