import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudMethods{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Future<void> addData(blogData) async{

    CollectionReference blogs = firestore.collection('blogs');
    blogs.add(blogData).catchError((e) {
      print(e);

    });
  }

  Future<void> updateScanData(scanData) async{

    CollectionReference lastScan = firestore.collection('lastScan');
    lastScan.doc(firebaseUser?.uid).set(scanData).catchError((e) {
      print(e);

    });
  }

  Future getData() async {
    return await firestore.collection('blogs').snapshots();
  }
}