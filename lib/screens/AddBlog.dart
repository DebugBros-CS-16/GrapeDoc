import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:grapedoc_test/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string/random_string.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  _AddBlogState createState() => _AddBlogState();
}

class validBlog {
   TextEditingController titleTest =TextEditingController();
   TextEditingController descriptionTest =TextEditingController();
   var test;
   var test2;


  blogPostTitle(TextEditingController titleTest1){
    if(titleTest.text == ""){
      return 'Title Can\'t Be Empty';
    }
  }

  blogPostDescription(TextEditingController descriptionTest1){
    if(descriptionTest.text == ""){
      return 'Description Can\'t Be Empty';
    }
  }
}

class _AddBlogState extends State<AddBlog> {
  //scaffoldKey
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late String title, desc;
  var titleTest;
  bool _validate = false;
  final _text = TextEditingController();
  final _text2 = TextEditingController();

  final validBlog input = new validBlog();

  File? selectedImage;
  bool _isLoading = false;
  CrudMethods crudMethods = CrudMethods();

  Future getImage() async{
    ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    // var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(image!.path);
    });
  }

  Future uploadBlog() async{
    if(selectedImage != null){
      if(title != "") {
        if(desc != "") {

          setState(() {
            _isLoading = true;

          });
        } else {
          desc = "Please enter description";
        }
      } else {
        titleTest = "Please enter title";

        // final snackBar = SnackBar(
        //   content: const Text("Please enter title"),
        //   duration: new Duration(seconds: 3),
        // );
        //
        // setState(() {
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // });

          // final snackBar = SnackBar(
          //   content: const Text("Please enter title"),
          //   duration: new Duration(seconds: 2),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);



        // _scaffoldKey.currentState.showSnackBar(
        //     SnackBar(
        //       content: new Text(title),
        //       duration: new Duration(seconds: 3),
        //     )
        // );
      }

      ////uploading image to firebase storage


      // try{
      //   await firebase_storage.FirebaseStorage.instance
      //       .ref()
      //       .putFile()
      // }on

      firebase_storage.Reference firebaseStorage = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      try {
        final task = await firebase_storage.FirebaseStorage.instance
            .ref().child("images/${randomAlphaNumeric(9)}.jpg")
            .putFile(selectedImage!);

        //final StorageUploadTask task = reference.putFile(selectedImage);
        var downloadUrl = await (await task).ref.getDownloadURL();

        print("this is url $downloadUrl");

        Map<String, String> blogMap = {
          "imgUrl": downloadUrl,
          "title": title,
          "desc": desc
        };

        crudMethods.addData(blogMap).then((result) => {
          Navigator.pop(context)
        });


      } on firebase_core.FirebaseException catch (e) {
        // e.g, e.code == 'canceled'
      }


    }else{

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
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
          GestureDetector(
            onTap: (){
              setState(() {
                _text.text.isEmpty ? _validate = true : _validate = false;
                _text2.text.isEmpty ? _validate = true : _validate = false;
                uploadBlog();
                if (selectedImage != null) {
                  showInSnackBar("Blog Added successfully", Color(0xFF323232), Colors.white);
                  showInSnackBar("!   Approval in progress", Color(0xFF323232), Colors.orange);

                };
                // showInSnackBar("Blog Added successfully");

              });

                // if (title=="") {
                //   final snackBar = SnackBar(
                //     content: const Text("Please enter title"),
                //     duration: new Duration(seconds: 3),
                //   );
                //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // }
                // setState(() {
                //   if (title == "");
                // });
                // showInSnackBar("SignUp succesfull");
              // }else {
              //   final snackBar = SnackBar(
              //     content: const Text("Please enter title"),
              //     duration: new Duration(seconds: 2),
              //   );
              //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
              // }



            },

            child: Container(
                padding: const EdgeInsets.only(right: 35.0),
                child: const Icon(Icons.upload_sharp),
            ),
          ),
        ],
      ),
      body: _isLoading ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ) : Container(
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: selectedImage != null 
                ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: 200.0,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.file(
                        selectedImage!,
                        fit: BoxFit.cover,
                    ),
                  ),
              ) : Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.add_a_photo,
                  color: Colors.black45,
                  size: 30.0,
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                children: [
                  TextField(
                    controller: _text,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      // errorText: _validate ? 'Title Can\'t Be Empty' : null,),
                      errorText: _validate ? input.blogPostTitle(_text) : null,),
                    onChanged: (val){
                      title = val;
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextField(
                    controller: _text2,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      errorText: _validate ? input.blogPostDescription(_text) : null,),
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

  void showInSnackBar(String value, Color bgColor, Color textColor) {
    final snackBar = SnackBar(
      content: Text(value, style: TextStyle(color: textColor),),
      backgroundColor: bgColor,

      duration: new Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
  // void showInSnackBar2(String value) {
  //   final snackBar2 = SnackBar(
  //     content: Text(),
  //     backgroundColor: Colors.purple,
  //
  //     duration: new Duration(seconds: 3),
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar2);
  //
  // }
}
