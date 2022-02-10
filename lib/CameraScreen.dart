import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

import 'main.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}
double _minAvailableZoom = 1.0;
double _maxAvailableZoom = 5.0;
double _currentZoomLevel = 1.0;

class _CameraScreenState extends State<CameraScreen> {


  CameraController ? controller;
  bool _isCameraInitialized = false;
  final resolutionPresets = ResolutionPreset.values;
  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final prevoiusCameraController = controller;

    final CameraController cameraController = CameraController(
        cameraDescription,
        currentResolutionPreset,
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



    cameraController
        .getMaxZoomLevel()
        .then((value) => _maxAvailableZoom = value);

    cameraController
        .getMinZoomLevel()
        .then((value) => _minAvailableZoom = value);

  }

  @override
  void initState() {
    onNewCameraSelected(cameras[0]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // return const Center(child: Text('Camera'));;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Container(
              child:  Row(
                children : [
                DropdownButton<ResolutionPreset>(
                  dropdownColor: Colors.black87,
                  underline: Container(),
                  value: currentResolutionPreset,
                  items: [
                    for (ResolutionPreset preset in resolutionPresets)
                      DropdownMenuItem(
                        child: Text(
                          preset
                              .toString()
                              .split('.')[1]
                              .toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                        value: preset,
                      )
                  ],
                  onChanged: (value){
                    setState(() {
                      currentResolutionPreset = value!;
                      _isCameraInitialized = false;
                    });
                    onNewCameraSelected(controller!.description);
                  },
                  hint: Text("Select item"),
                ),
                ],
              ),
            ),
            _isCameraInitialized
                ? AspectRatio(
              aspectRatio: 1 / controller!.value.aspectRatio,
              child: controller!.buildPreview(),
            )
                : Container(),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _currentZoomLevel,
                      min: _minAvailableZoom,
                      max: _maxAvailableZoom,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white30,
                      onChanged: (value) async {
                        setState(() {
                          _currentZoomLevel = value;
                        });
                        await controller!.setZoomLevel(value);
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _currentZoomLevel.toStringAsFixed(1) +
                            'x',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
