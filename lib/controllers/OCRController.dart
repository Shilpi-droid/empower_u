

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:empower_u/views/widgets/read_result.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';

class OCRController extends StatefulWidget {
  const OCRController({Key? key}) : super(key: key);

  @override
  State<OCRController> createState() => _OCRControllerState();
}

class _OCRControllerState extends State<OCRController> with WidgetsBindingObserver {
  bool _isPermissionGranted = false;
  late final Future<void> _future;
  CameraController? _cameraController;
  final _textRecognizer=TextRecognizer();

  @override void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    // super.didChangeAppLifecycleState(state);
    if(_cameraController == null || !_cameraController!.value.isInitialized)return;
    if(state ==AppLifecycleState.inactive)
      {
        _stopCamera();
      }
    else if(
    state== AppLifecycleState.resumed &&
        _cameraController!=null &&
        _cameraController!.value.isInitialized
    )
      {
        _startCamera();
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _future=_requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    _textRecognizer.close();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
      builder: (context,snapshot)
      {
        return Stack(
          children: [
            if(_isPermissionGranted)
              FutureBuilder<List<CameraDescription>>(
                  future: availableCameras(),
                  builder: (context,snapshot)
                  {
                    if(snapshot.hasData)
                      {
                        _initCameraController(snapshot.data!);
                        return Center(
                          child: CameraPreview(_cameraController!),
                        );
                      }
                    else return const LinearProgressIndicator();
                  }
              ),
              Scaffold(
              backgroundColor: _isPermissionGranted?Colors.transparent:null,
              body:_isPermissionGranted?
                  Column(
                    children: [
                      Expanded(child: Container()),
                      Container(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: _scanImage,
                            child: Text("Scan text"),
                          ),
                        ),
                      )
                    ],
                  ):
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 24,right: 24),
                      child:  const Text(
                        "Camera permission denied",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              // Center(
              //   child: Text(
              //     _isPermissionGranted
              //     ?'Camera Permission Granted'
              //         :'Camera permission denied',
              //         textAlign: TextAlign.center,
              //   ),
              // )
            ),
          ],
        );


      },
    );

  }
  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }

    // Select the first rear camera.
    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    await _cameraController!.setFlashMode(FlashMode.off);

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> _scanImage() async {
    if (_cameraController == null) return;

    final navigator = Navigator.of(context);

    try {
      final pictureFile = await _cameraController!.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file as File);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ReadResult(text: recognizedText.text),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }
}