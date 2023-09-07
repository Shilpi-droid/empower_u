
// import 'package:alan_voice/alan_voice.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empower_u/views/constants/strings.dart';
import 'package:empower_u/views/screens/blind.dart';
import 'package:empower_u/views/screens/community/home_screen.dart';
import 'package:empower_u/views/screens/deaf.dart';
import 'package:empower_u/views/screens/walking_mode.dart';
import 'package:empower_u/views/widgets/option_tile2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:velocity_x/velocity_x.dart';


import '../../controllers/OCRController.dart';
import '../constants/firebase_constants.dart';
import '../widgets/option_tile.dart';
import 'community/verification_screen.dart';
import 'mute.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}


class _RootPageState extends State<RootPage> {


  // _RootPageState() {
  //   /// Init Alan Button with project key from Alan AI Studio
  //   AlanVoice.addButton("aafbd1131282a024a6ff8f9210321c132e956eca572e1d8b807a3e2338fdd0dc/stage");
  //
  //   /// Handle commands from Alan AI Studio
  //   AlanVoice.onCommand.add((command) {
  //     debugPrint("got new command ${command.toString()}");
  //   });
  // }
  void _handleCommand(Map<String, dynamic> command) {
    switch(command["command"]){
      case "blind":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Blind(),
          ),
        );
      break;
      case "deaf":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Deaf(),
          ),
        );
        break;
      case "community":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => isUser?HomeScreen(username: username,):VerificationScreen(),
          ),
        );
        break;
      case "walk":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WalkingMode()
          ),
        );
        break;
      case "read":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OCRController()
          ),
        );
        break;
        default: debugPrint("unknown command");

    }
    // Handle voice commands here
  }

  bool isAlanActive = false;

  var isUser=false;
  String username="";
  checkUser()async{

    auth.authStateChanges().listen((User? user)async{

      if(user == null && mounted)
        {
          setState(() {
            isUser = false;
          });
        }
      else
        {
          setState(() {
            isUser = true;
          });
        }
      if(isUser) {
        final userDoc = await FirebaseFirestore.instance.collection('users')
            .doc(user!.uid)
            .get();
        if (userDoc.exists) {
          setState(() {
            username = userDoc['name'] as String;
          });
        }
      }
      print("User value ${isUser}");
      print("Username: $username");

    });
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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomPopup(
            title: 'Voice Assistant',
            message: 'Do you need voice assistance?',
            onOkPressed: () {
              // Handle OK button press
              AlanVoice.addButton("aafbd1131282a024a6ff8f9210321c132e956eca572e1d8b807a3e2338fdd0dc/stage");
                /// Handle commands from Alan AI Studio
              AlanVoice.onCommand.add((command) => _handleCommand(command.data));
                speakLabel("There are three options in this page: open vision,        open lecture mode        and open community which one do you want to proceed with?");
              print('OK button pressed');
            },
            isAlanPressed:isAlanActive
          );
        },
      );
    });

    checkUser();
  }

  @override
  Widget build(BuildContext context) {

    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return  SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          body: Container(
            width: width,
            child: Column(
              children: [
                SizedBox(height: height*.3,),
                SizedBox(
                  height: height*.1,
                  width: width*.8,
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Blind(),
                          ),
                        );
                      },
                    style: ElevatedButton.styleFrom(
                        primary: btnColor, // Set the background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // Set the border radius
                        ),
                    ),
                      child:Row(

                        children: [
                            Image.asset("assets/images/Read.png"),
                            50.widthBox,
                            "Read".text.white.size(24).make(),
                        ],
                      )
                  ),
                ),
                SizedBox(height: height*.04,),
                SizedBox(
                  height: height*.1,
                  width: width*.8,
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Deaf(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: btnColor, // Set the background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // Set the border radius
                        ),
                      ),
                      child:Row(

                        children: [
                          Image.asset("assets/images/Listen.png"),
                          50.widthBox,
                          "Listen".text.white.size(24).make(),
                        ],
                      )
                  ),
                ),
                SizedBox(height: height*.04,),
                SizedBox(
                  height: height*.1,
                  width: width*.8,
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => isUser?HomeScreen(username: username,):VerificationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: btnColor, // Set the background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // Set the border radius
                        ),
                      ),
                      child:Row(

                        children: [
                          Image.asset("assets/images/Community.png"),
                          50.widthBox,
                          "Community".text.white.size(24).make(),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

class CustomPopup extends StatefulWidget {
  final String title;
  final String message;
  final Function onOkPressed;
  final bool isAlanPressed;

  CustomPopup({
    required this.title,
    required this.message,
    required this.onOkPressed,
    required this.isAlanPressed
  });

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    speakLabel(widget.message);
  }
  // void dispose() {
  //   // TODO: implement dispose
  //     AlanVoice.activate();
  //   super.dispose();
  // }


  Future<void> speakLabel(String label) async {
    if (!isSpeaking) {
      isSpeaking = true; // Lock speech

      await flutterTts.setLanguage('en-US');
      await flutterTts.setPitch(1.0);

      try {
        await flutterTts.speak(label);

        // Pause the execution for the specified duration
        await Future.delayed(Duration(seconds: 10));

      } finally {
        await flutterTts.stop();
        isSpeaking = false; // Release the lock
      }
    }
  }
  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking=false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the popup
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the popup
            widget.onOkPressed(); // Execute the provided function
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

