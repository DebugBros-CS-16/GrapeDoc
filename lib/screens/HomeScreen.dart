import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grapedoc_test/screens/FeedScreen.dart';
import 'package:grapedoc_test/screens/NavBar.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Services/crud.dart';
import 'BlogScreen.dart';
import 'CaptureScreen.dart';
import 'ChatScreen.dart';
import 'NavBar.dart';

class HomeScreen extends StatefulWidget {
  //final int index;
  //final Stream<int> stream;
  //StreamController<int> streamController = StreamController<int>();
  
  //HomeScreen(this.index,this.stream);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CrudMethods crudMethods = CrudMethods();
  late FirebaseFirestore firestore;

  bool _isLoading = false;
  var disease;
  var imgUrl;

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('lastScan')
          .doc(firebaseUser.uid)
          .get()
          .then((value) {
        disease = value.data()!['title'];
        imgUrl = value.data()!['imgUrl'];
        print("fetched last scan data");
      }).catchError((e) {
        print(e);
      });
    }

    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          // Container(
          //   margin: const EdgeInsets.all(10.0),
          //   height: 250.0,
          //   child: ListView(
          //     scrollDirection: Axis.horizontal,
          //     children: [
          //       // Container(
          //       //   margin: const EdgeInsets.only(right: 10.0),
          //       //   width: 200.0,
          //       //   color: Colors.purple,
          //       // ),
          //       // Container(
          //       //   margin: const EdgeInsets.only(right: 10.0),
          //       //   width: 200.0,
          //       //   color: Colors.green,
          //       // ),
          //       // Container(
          //       //   margin: const EdgeInsets.only(right: 10.0),
          //       //   width: 200.0,
          //       //   color: Colors.pink,
          //       // ),
          //       // Container(
          //       //   margin: const EdgeInsets.only(right: 10.0),
          //       //   width: 200.0,
          //       //   color: Colors.purple,
          //       // ),
          //       // Container(
          //       //   margin: const EdgeInsets.only(right: 10.0),
          //       //   width: 200.0,
          //       //   color: Colors.green,
          //       // ),
          //       // Container(
          //       //   width: 200.0,
          //       //   color: Colors.pink,
          //       // ),
          //
          //      ],
          //   ),
          // ),
          SizedBox(
            height: 20.0,
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    FutureBuilder(
                        future: _fetch(),
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Text(
                                        'Last Scanned',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ))),
                              SizedBox(
                                height: 5.0,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Text(
                                        disease != null
                                            ? 'State : $disease'
                                            : 'State : No Data Found',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ))),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                child: imgUrl == null
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        height: 250.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child:  Center(
                                            child: const Text(
                                                'No Last Scans Found')))
                                    : Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        height: 250.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: _isLoading
                                              ? CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                Image.asset("assets/images/grapedoclogo.png"),
                                            imageUrl: imgUrl,
                                            width: MediaQuery.of(context).size.width,
                                            fit: BoxFit.cover,
                                          )
                                              : Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                        ),
                                      ),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => CaptureScreen()));
                  streamController.add(0);
                },
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    //border: Border.all(color: Colors.black12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(2, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.camera_alt_rounded,color: Colors.black,),
                      Text("Scan", style: TextStyle(color: Colors.black),)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ChatScreen()));
                  streamController.add(2);
                },
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    //border: Border.all(color: Colors.black12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(2, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.chat_rounded,color: Colors.black,),
                      Text("Chat", style: TextStyle(color: Colors.black),)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => BlogScreen()));
                  streamController.add(3);
                },
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    //border: Border.all(color: Colors.black12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(2, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.web,color: Colors.black,),
                      Text("Blog", style: TextStyle(color: Colors.black),)
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeedScreen()));
            },
            child: Container(
              height: 150.0,
              width: double.infinity,
              padding:
                  const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              //color: Colors.blue,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(2, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Interested in learning\nmore about grapes?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        "Click Here...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      "assets/images/grapesicon.png",
                      height: 100.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeedScreen()));
            },
            child: Container(
              height: 200.0,
              width: double.infinity,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              //color: Colors.blue,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(2, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   height: 200.0,
          //   width: double.infinity,
          //   margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          //   color: Colors.blue,
          // ),
          // Container(
          //   height: 200.0,
          //   width: double.infinity,
          //   margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          //   color: Colors.red,
          // ),
          // Container(
          //   height: 200.0,
          //   width: double.infinity,
          //   margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          //   color: Colors.green,
          // ),
          // Container(
          //   height: 200.0,
          //   width: double.infinity,
          //   margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          //   color: Colors.amber,
          // ),
          // Container(
          //   child: body(),
          // ),
        ],
      ),
    );
  }
}
