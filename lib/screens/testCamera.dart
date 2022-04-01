// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';
// //import 'package:firebase_ml_vision/firebase_ml_vision.dart';
//
// class TestCamera extends StatefulWidget {
//   const TestCamera({Key? key}) : super(key: key);
//
//   @override
//   State<TestCamera> createState() => _TestCameraState();
// }
//
// class _TestCameraState extends State<TestCamera> {
//   File? imageFile;
//   // String result = '';
//   // late ImageLabeler labeler;
//
// // //TODO declare ImageLabeler
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     //TODO initialize labeler
// //     labeler = FirebaseVision.instance.imageLabeler();
// //   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       // appBar: AppBar(
//       //   title: const Text('Capturing Images'),
//       //   centerTitle: true,
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             imageFile != null
//                 ? Container(
//                     width: 640,
//                     height: 480,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: Colors.grey,
//                       image: DecorationImage(
//                           image: FileImage(imageFile!), fit: BoxFit.cover),
//                       border: Border.all(width: 8, color: Colors.black),
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   )
//                 : Container(
//                     width: 640,
//                     height: 480,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: Colors.grey,
//                       border: Border.all(width: 8, color: Colors.black12),
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: const Text(
//                       'Image should appear here',
//                       style: TextStyle(fontSize: 26),
//                     ),
//                   ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                       onPressed: () => getImage(source: ImageSource.camera),
//                       child: const Text('Capture Image',
//                           style: TextStyle(fontSize: 18))),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 Expanded(
//                   child: ElevatedButton(
//                       onPressed: () => getImage(source: ImageSource.gallery),
//                       child: const Text('Select Image',
//                           style: TextStyle(fontSize: 18))),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void getImage({required ImageSource source}) async {
//     print(
//         "--------------------------------------------11111-------------------------------------------");
//     print(
//         "---------------------------------------------11111------------------------------------------");
//
//     final file = await ImagePicker().pickImage(
//         source: source,
//         maxWidth: 640,
//         maxHeight: 480,
//         imageQuality: 70 //0 - 100
//         );
//
//     print(
//         "---------------------------------------22222------------------------------------------------");
//     print(
//         "---------------------------------------22222-----------------------------------------------");
//
//     if (file?.path != null) {
//       setState(() {
//         print(
//             "-----------------------------------33333----------------------------------------------------");
//         print(
//             "-----------------------------------33333----------------------------------------------------");
//
//         imageFile = File(file!.path);
//         print(
//             "------------------------------------44444---------------------------------------------------");
//         print(
//             "------------------------------------44444---------------------------------------------------");
//         applyModelOnImage(imageFile!);
//         print(
//             "-------------------------------------55555--------------------------------------------------");
//         print(
//             "-------------------------------------55555--------------------------------------------------");
//         //doImageLabeling();
//       });
//     }
//   }
//
//   late List _result;
//
//   String _confidence = "";
//   String _name = "";
//
//   String numbers = '';
//
//   loadModel() async {
//     var resultant = await Tflite.loadModel(
//         labels: "assets/ml_model/labels.txt",
//         model: "assets/ml_model/model.tflite",
//         numThreads: 1, // defaults to 1
//         isAsset:
//             true, // defaults to true, set to false to load resources outside assets
//         useGpuDelegate:
//             false // defaults to false, set to true to use GPU delegate
//         );
//
//     print(
//         "---------------------------------------------------------------------------------------");
//     print(
//         "---------------------------------------------------------------------------------------");
//     print(
//         "---------------------------------------------------------------------------------------");
//     print("Result after loading model: $resultant");
//     print(
//         "---------------------------------------------------------------------------------------");
//     print(
//         "---------------------------------------------------------------------------------------");
//     print(
//         "---------------------------------------------------------------------------------------");
//   }
//
//   applyModelOnImage(File file) async {
//     print(
//         "------------------------------------666666---------------------------------------------------");
//     print(
//         "------------------------------------666666---------------------------------------------------");
//     var res = await Tflite.runModelOnImage(
//       path: file.path,
//       numResults: 2,
//       threshold: 0.2,
//       imageMean: 117.0,
//       imageStd: 127.5,
//       asynch: true,
//     );
//
//     await Tflite.close();
//
//     print(
//         "-------------------------------------777777--------------------------------------------------");
//     print(
//         "--------------------------------------77777-------------------------------------------------");
//
//     setState(() {
//       print(
//           "--------------------------------888888-------------------------------------------------------");
//       print(
//           "--------------------------------888888-------------------------------------------------------");
//       _result = res!;
//       print(
//           "---------------------------------99999------------------------------------------------------");
//       print(
//           "---------------------------------99999------------------------------------------------------");
//
//       String str = _result[0]["label"];
//       print(
//           "---------------------------------10101010------------------------------------------------------");
//       print(
//           "----------------------------------10101010-----------------------------------------------------");
//       _name = str.substring(2);
//       print(
//           "----------------------------------11-11-11-11------------------------------------------------------");
//       print(
//           "-----------------------------------11-11-11-11----------------------------------------------------");
//       _confidence = _result != null
//           ? (_result[0]['confidence'] * 100.0).toString().substring(0, 2) + "%"
//           : "";
//       print(
//           "-----------------------------------12-12-12-12----------------------------------------------------");
//       print(
//           "-----------------------------------12-12-12-12----------------------------------------------------");
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//   }
//
// // //TODO image labeling code here
//   // doImageLabeling() async {
//   //   result= " ";
//   //   final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile!);
//   //
//   //   final List<ImageLabel> labels = await labeler.processImage(visionImage);
//   //   for(ImageLabel li in labels){
//   //     result+=li.text!+"   "+li.confidence!.toStringAsFixed(2)+"\n";
//   //     print(result);
//   //   }
//   //   setState(() {
//   //     result;
//   //   });
//   // }
// }
