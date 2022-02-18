import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudMethods{

  Future<void> addData(blogData) async{

    CollectionReference blogs = FirebaseFirestore.instance.collection('blogs');
    blogs.add(blogData).catchError((e) {
      print(e);
    });
  }
}