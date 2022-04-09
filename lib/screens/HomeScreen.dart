import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grapedoc_test/screens/FeedScreen.dart';


import '../Services/crud.dart';
import 'BlogScreen.dart';
import 'ChatScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                                    child: Center(
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
                                        ? Image.network(
                                      imgUrl,
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
            height: 10.0,
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
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
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
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
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
