import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grape_doc/Services/crud.dart';
import 'package:grape_doc/screens/AddBlog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:grape_doc/screens/testblog.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  CrudMethods crudMethods = CrudMethods();

  Stream? blogsStream;

  Widget BlogList(){
    return Container(
      child: blogsStream != null ? Column(
        children: [
          StreamBuilder<dynamic>(
            stream: blogsStream,
            builder: (context, snapshot){
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return BlogsTile(
                      title: snapshot.data.docs[index]['title'],
                      desc: snapshot.data.docs[index]['desc'],
                      imgUrl: snapshot.data.docs[index]['imgUrl'],
                    );
                  });
            })
        ],
      ): Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    crudMethods.getData().then((result) {
      blogsStream = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlogList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddBlog()));
        },
      ),
    );
  }
}

class BlogsTile extends StatelessWidget {

  String imgUrl, title, desc;
  BlogsTile(
      { required this.imgUrl,
        required this.title,
        required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      height: 150,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                width: MediaQuery.of(context).size.width,
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
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title),
                Text(desc),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

