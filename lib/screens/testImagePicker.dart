import 'dart:io';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'classifier.dart';
import 'classifier_quant.dart';
import 'package:logger/logger.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

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

class TestImagePicker extends StatefulWidget {
  TestImagePicker({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _TestImagePickerState createState() => _TestImagePickerState();
}

class _TestImagePickerState extends State<TestImagePicker> {
  late Classifier _classifier;

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

    setState(() {
      this.category = pred;
    });
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
