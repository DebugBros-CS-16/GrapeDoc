import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grape_doc/widgets/Home_news_widget.dart';

import '../Services/crud.dart';
import 'BlogScreen.dart';
import 'CameraScreen.dart';
import 'ChatScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CrudMethods crudMethods = CrudMethods();
  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    crudMethods.getData().then((result) {
      blogsStream = result;
    });
  }

  Stream? blogsStream;

  @override
  Widget build(BuildContext context) {
    return
    //   HomeNews();
      Container(
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
                // Container(
                //   margin: const EdgeInsets.only(right: 10.0),
                //   width: 200.0,
                //   color: Colors.purple,
                // ),
                // Container(
                //   margin: const EdgeInsets.only(right: 10.0),
                //   width: 200.0,
                //   color: Colors.green,
                // ),
                // Container(
                //   margin: const EdgeInsets.only(right: 10.0),
                //   width: 200.0,
                //   color: Colors.pink,
                // ),
                // Container(
                //   margin: const EdgeInsets.only(right: 10.0),
                //   width: 200.0,
                //   color: Colors.purple,
                // ),
                // Container(
                //   margin: const EdgeInsets.only(right: 10.0),
                //   width: 200.0,
                //   color: Colors.green,
                // ),
                // Container(
                //   width: 200.0,
                //   color: Colors.pink,
                // ),
                StreamBuilder<dynamic>(
                    stream: firestore.collection('blogs').snapshots() ,
                    builder: (context, snapshot){
                      if (!snapshot.hasData) return Center(child: const CircularProgressIndicator());
                      return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          itemCount: snapshot.data.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            return BlogsTile(
                              title: snapshot.data.docs[index]['title'],
                              imgUrl: snapshot.data.docs[index]['imgUrl'],
                            );
                          });
                    }),
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

class BlogsTile extends StatelessWidget {

  String imgUrl, title;
  BlogsTile(
      { required this.imgUrl,
        required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      width: MediaQuery.of(context).size.width/2,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                width: MediaQuery.of(context).size.width/3,
                fit: BoxFit.cover,
              )
          ),
          Container(
            height: 150.0,
            decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width/3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title),
              ],
            ),
          ),
        ],
      ),
    );
  }
}