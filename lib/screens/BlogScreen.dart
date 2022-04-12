import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grapedoc_test/Services/crud.dart';
import 'package:grapedoc_test/screens/AddBlog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:readmore/readmore.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  CrudMethods crudMethods = CrudMethods();
  late FirebaseFirestore firestore;

  Stream? blogsStream;

  Widget BlogList() {
    return Container(
        child: blogsStream == null
            ? ListView(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  StreamBuilder<dynamic>(
                      stream: firestore.collection('blogs').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                              child: const CircularProgressIndicator());
                        return Container(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return BlogsTile(
                                  title: snapshot.data.docs[index]['title'],
                                  desc: snapshot.data.docs[index]['desc'],
                                  imgUrl: snapshot.data.docs[index]['imgUrl'],
                                );
                              }),
                        );
                      }),
                ],
              )
            : Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ));
  }

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    crudMethods.getData().then((result) {
      blogsStream = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlogList(),
      floatingActionButton: Align(
        alignment: Alignment(0.97,1.0),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddBlog()));
          },
        ),
      ),
    );
  }
}

class BlogsTile extends StatelessWidget {
  String imgUrl, title, desc;
  BlogsTile({required this.imgUrl, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 15.0),
      padding: const EdgeInsets.only(bottom: 10.0),
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
          Container(
            child: imgUrl == null
                ? Container(
                    height: 150.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Center(
                      child: const Text('No Last Scans Found'),
                    ),
                  )
                : Container(
                    height: 150.0,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                              Image.asset("assets/images/grapedoclogo.png"),
                          imageUrl: imgUrl,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )),
                  ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ))),
                SizedBox(
                  height: 5.0,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: ReadMoreText(
                        desc,
                        trimLines: 3,
                        textAlign: TextAlign.justify,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: "Read more",
                        trimExpandedText: "Read less",
                        lessStyle: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        moreStyle: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Text(title),
          //       Text(desc),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
