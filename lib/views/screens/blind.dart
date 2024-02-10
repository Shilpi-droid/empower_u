
import 'package:camera/camera.dart';
import 'package:empower_u/controllers/OCRController.dart';
import 'package:empower_u/views/screens/walking_mode.dart';
import 'package:flutter/material.dart';
import 'package:empower_u/main.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../widgets/mode_button.dart';

class Blind extends StatefulWidget {
  const Blind({Key? key}) : super(key: key);

  @override
  State<Blind> createState() => _BlindState();
}

class _BlindState extends State<Blind> {

@override
  void initState() {
    // TODO: implement initState
  // speakLabel("There are two options in this page:walking mode and read mode which one do you want to proceed with?");
    super.initState();
  }
Future<void> speakLabel(String label) async {
  if (!isSpeaking) {
    isSpeaking = true; // Lock speech

    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);

    try {
      await flutterTts.speak(label);

      // Pause the execution for the specified duration
      await Future.delayed(Duration(seconds: 7));

    } finally {
      await flutterTts.stop();
      isSpeaking = false; // Release the lock
    }
  }
}
bool isSpeaking=false;

final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return
      Scaffold(
      backgroundColor:Color(0xff2A2C28),
      body: Row(
        children: [
          Container(
            height: height,
              width: width*.75,
              color:Color(0xff151413),
            child: Column(
              children: [
                SizedBox(height: height*.225,),
                ModeButton(text: "Walking Mode",page: WalkingMode(),),
                SizedBox(height: height*.05,),
                ModeButton(text: "Read Mode",page: OCRController()),
                // SizedBox(height: height*.05,),
                // ModeButton(text: "Currency Mode",page: Center(child: Text("Comming Soon!"),),),
              ],
            ),
          )
        ],
      ),
    );



  }
}



