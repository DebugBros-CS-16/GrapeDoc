import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'main.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {


  CameraController ? controller;
  bool _isCameraInitialized = false;

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final prevoiusCameraController = controller;

    final CameraController cameraController = CameraController(
        cameraDescription,
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.jpeg
    );

    await prevoiusCameraController?.dispose();

    if (mounted){
      setState(() {
        controller = cameraController;
      });
    }

    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try{
      await cameraController.initialize();
    } on CameraException catch (e){
      print('Error initializing camera: $e');
    }

    if(mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    onNewCameraSelected(cameras[0]);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // return const Center(child: Text('Camera'));;
    return Scaffold(
        body: _isCameraInitialized
            ? AspectRatio(
               aspectRatio: 1/controller!.value.aspectRatio,
               child: controller!.buildPreview(),
        )
            : Container(),
    );
  }
}
