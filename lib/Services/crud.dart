import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudMethods{

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addData(blogData) async{

    CollectionReference blogs = firestore.collection('blogs');
    blogs.add(blogData).catchError((e) {
      print(e);

    });
  }

  Future getData() async {
    return await firestore.collection('blogs').snapshots();
  }
}