import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:grape_doc/Services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string/random_string.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {

  late String title, desc;

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

      setState(() {
        _isLoading = true;
      });

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

        print("this is url$downloadUrl");

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
              uploadBlog();
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
