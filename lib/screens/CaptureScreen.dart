import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'classifier.dart';
import 'classifier_quant.dart';
import 'package:logger/logger.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'dart:convert';

class CaptureScreen extends StatefulWidget {
  CaptureScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _CaptureScreenState createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  late Classifier _classifier;

  List _data = [];

  var diseaseType;
  var cause;
  var symptoms;
  var solution;

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

  Future imageCheck() async {
    if (_image != null) {
      setState(() {
        _isLoading = true;
      });
    }
    _predict();
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);
    readJson();
    setState(() {
      this.category = pred;
    });
  }

  Future<void> readJson() async {
    final response = await rootBundle.loadString('assets/Solutions.json');
    // final data = await jsonDecode(response)as List;
    Map<String, dynamic> map = json.decode(response);
    List<dynamic> data = map["data"];
    print(data[0]["id"]);
    setState(() {
      _data = data;
      getSolutions();
    });
  }

//Create  a method check if else for loop.
  void getSolutions() async {
    for (var i = 0; i <= _data.length-1; i++) {
      if ((category!.label) == _data[i]["id"]) {
        diseaseType = _data[i]["id"];
        cause = _data[i]["Cause"];
        symptoms = _data[i]["Symptoms"];
        solution = _data[i]["Solution"];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          body: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
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
                          child: Center(child: const Text('Select Image File')))
                      : Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          height: 300.0,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: _isLoading
                                ? Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  )
                                : Center(child: CircularProgressIndicator()),
                          ),
                        ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  diseaseType != null ? '${diseaseType}' : 'Disease',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  // textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 240,
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: const Text(
                              "Cause",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Text(
                              cause != null ? '${cause}' : '',
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: const Text(
                              "Symptoms",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Text(
                              symptoms != null ? '${symptoms}' : '',
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: const Text(
                              "Solution",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Text(
                              solution != null ? '${solution}' : '',
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  onTap: getImageFromGallery),
              SpeedDialChild(
                  child: Icon(Icons.add_a_photo),
                  backgroundColor: Colors.purple,
                  label: 'Camera',
                  onTap: getImageFromCamera)
            ],
          )),
    );
  }
}
