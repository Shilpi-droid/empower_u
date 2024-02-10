import 'package:alan_voice/alan_voice.dart';
import 'package:camera/camera.dart';
import 'package:empower_u/controllers/scan_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../../controllers/sensor_data.dart';

//Distance Mode

class WalkingMode extends StatefulWidget {

  WalkingMode({Key? key}) : super(key: key);

  @override
  State<WalkingMode> createState() => _WalkingModeState();
}

class _WalkingModeState extends State<WalkingMode> {


   Future<void> speakLabel(String label) async {
     if (!isSpeaking) {
       isSpeaking = true; // Lock speech

       await flutterTts.setLanguage('en-US');
       await flutterTts.setPitch(1.0);

       try {
         await flutterTts.speak(label);

         // Pause the execution for the specified duration
         await Future.delayed(Duration(seconds: 1));

       } finally {
         await flutterTts.stop();
         isSpeaking = false; // Release the lock
       }
     }
   }

    final FlutterTts flutterTts = FlutterTts();

    bool isSpeaking=false;
   final distanceDataService = DistanceDataProvider();

   @override
   void initState() {
     super.initState();
    distanceDataService.startListeningToDistance();
   }

   @override
   void dispose() {
     distanceDataService.stopListeningToDistance();
     super.dispose();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ScanController>(
        init: ScanController(),
        builder: (controller) {
          if (controller.isCameraInitialized.value) {
            if (controller.label.isNotEmpty) speakLabel(controller.label);
            return Stack(
              children: [
                CameraPreview(controller.cameraController!),
                if (controller.label.isNotEmpty)
                  Positioned(
                    top: controller.y * 500,
                    right: controller.x * 700,
                    child: Container(
                      // width:100,
                      // height: 100,
                      width: controller.w * 100 * context.width / 100,
                      height: controller.h * 100 * context.height / 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 4.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            color: Colors.white,
                            child: Text(controller.label),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          } else {
            return Center(child: const Text("Loading Preview ..."));
          }
        },
      ),
    );
  }
}
