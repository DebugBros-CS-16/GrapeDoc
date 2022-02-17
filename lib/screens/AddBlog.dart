import 'package:flutter/material.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {

  late String title, desc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text(
          'Add new blog',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 35.0),
              onPressed:(){},
              icon: const Icon(Icons.upload_sharp)
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(
                Icons.add_a_photo,
                color: Colors.black45,
                size: 30.0,
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: 'Title'),
                    onChanged: (val){
                      title = val;
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextField(
                    decoration: InputDecoration(hintText: 'Description'),
                    onChanged: (val){
                      desc = val;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
