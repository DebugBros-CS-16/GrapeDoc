import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grape_doc/Services/crud.dart';
import 'package:grape_doc/screens/AddBlog.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  CrudMethods crudMethods = CrudMethods();

  QuerySnapshot? blogsSnapshot;

  Widget BlogList(){
    return Container(
      child: blogsSnapshot != null ? Column(
        children: [
          ListView.builder(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0
            ),
            itemCount: blogsSnapshot?.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              return BlogsTile(
                title: blogsSnapshot?.docs[index].data['title'],
                desc: blogsSnapshot?.docs[index].data['desc'],
                imgUrl: blogsSnapshot?.docs[index].data['imgUrl'],
              );
            }
            )
        ],
      ): Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    crudMethods.getData().then((result) {
      blogsSnapshot = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

      ),
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
              child: Image.network(
                imgUrl,
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

