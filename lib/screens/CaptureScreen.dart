import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Services/crud.dart';
import 'classifier.dart';
import 'classifier_quant.dart';
import 'package:logger/logger.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:random_string/random_string.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image Classification',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class CaptureScreen extends StatefulWidget {
  CaptureScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _CaptureScreenState createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  late Classifier _classifier;

  late String title, desc;
  CrudMethods crudMethods = CrudMethods();

  var logger = Logger();

  File? _image;
  final picker = ImagePicker();

  Image? _imageWidget;

  img.Image? fox;

  Category? category;

  bool _isLoading = false;

  final isDialOpen = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _classifier = ClassifierQuant();
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);

      imageCheck();
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);

      imageCheck();
    });
  }

  Future imageCheck() async{
    if(_image != null){

        setState(() {
          _isLoading = true;
        });
      }
    _predict();
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);
    uploadLastScan();

    setState(() {
      this.category = pred;
    });
  }

  Future uploadLastScan() async{
    firebase_storage.Reference firebaseStorage = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("lastScans")
        .child("${randomAlphaNumeric(9)}.jpg");

    try {
      final task = await firebase_storage.FirebaseStorage.instance
          .ref().child("lastScans/${randomAlphaNumeric(9)}.jpg")
          .putFile(_image!);

      //final StorageUploadTask task = reference.putFile(selectedImage);
      var downloadUrl = await (await task).ref.getDownloadURL();

      print("this is url$downloadUrl");

      Map<String, String> lastScanMap = {
        "imgUrl": downloadUrl,
        "title": category!.label,
      };

      crudMethods.updateScanData(lastScanMap);


    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              Container(
                child: _image == null
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        height: 300.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(child: const Text('Select Image File'))
                )
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        height: 300.0,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: _isLoading ? Image.file(
                               _image!,
                              fit: BoxFit.cover,
                            ): Center(child: CircularProgressIndicator()),
                            ),
                      ),
              ),
              SizedBox(
                height: 36,
              ),
              Text(
                category != null ? category!.label : '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                category != null
                    ? 'Confidence: ${category!.score.toStringAsFixed(3)}'
                    : '',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Colors.purple,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          spacing: 10,
          spaceBetweenChildren: 8,
          //closeManually: true,
          openCloseDial: isDialOpen,
          children: [
            SpeedDialChild(
              child: Icon(Icons.add_photo_alternate_outlined),
              backgroundColor: Colors.purple,
              label: 'Device',
              onTap: getImageFromGallery
            ),
            SpeedDialChild(
              child: Icon(Icons.add_a_photo),
              backgroundColor: Colors.purple,
              label: 'Camera',
              onTap: getImageFromCamera
            )
          ],
        )
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     FloatingActionButton(
        //       onPressed: getImageFromCamera,
        //       tooltip: 'Pick Image From Camera',
        //       child: Icon(Icons.add_a_photo),
        //     ),
        //     const SizedBox(
        //       height: 10.0,
        //     ),
        //     FloatingActionButton(
        //       onPressed: getImageFromGallery,
        //       tooltip: 'Pick Image From Gallery',
        //       child: Icon(Icons.add_photo_alternate_outlined),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
