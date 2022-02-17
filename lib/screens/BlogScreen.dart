import 'package:flutter/material.dart';
import 'package:grape_doc/screens/AddBlog.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
