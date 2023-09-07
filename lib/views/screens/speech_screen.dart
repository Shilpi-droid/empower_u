// Color(0xff00A67E): bg color
//Color(0xffFEFDFC): text color


import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {

  SpeechToText speechToText = SpeechToText();
  var text="Hold the button and start speaking";
  var isListening= false;
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75.0,
        animate: isListening,
        duration: Duration(seconds: 2),
        glowColor: Color(0xff00A67E),
        repeat: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        showTwoGlows: true ,
        child: GestureDetector(
          // onTap: () async
          // {
          //   setState(() {
          //     isListening=!isListening;
          //   });
          //   if(isListening)speechToText.stop();
          //   if(!isListening)
          //    {
          //      var available = await speechToText.initialize();
          //      if(available)
          //        {
          //          setState(() {
          //            isListening=true;
          //            speechToText.listen(
          //              onResult: (result)
          //              {
          //                 setState(() {
          //                   text= result.recognizedWords;
          //
          //                 });
          //              }
          //            );
          //          });
          //        }
          //    }
          // },
          onTapDown: (details) async{
           if(!isListening)
             {
               var available = await speechToText.initialize();
               if(available)
                 {
                   setState(() {
                     isListening=true;
                     speechToText.listen(
                       onResult: (result)
                       {
                          setState(() {
                            text= result.recognizedWords;

                          });
                       }
                     );
                   });
                 }
             }
          },
          onTapUp: (details){
            setState(() {
              isListening=false;
              speechToText.stop();
            });
          },
          child: CircleAvatar(
            backgroundColor: Color(0xff00A67E),
            radius: 35,
            child: Icon(isListening?Icons.mic:Icons.mic_none ,color: Colors.white,),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor:  Color(0xff00A67E) ,
        leading: const Icon(Icons.sort_rounded,color: Colors.white,),
        title: Text(
            "Speech To Text",
            style:TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xffFEFDFC),
            )),
      ),
      body: SingleChildScrollView(
        reverse: true,
        physics: BouncingScrollPhysics(),
        child: Container(
          height: height*.7,
            width: width,
            alignment: Alignment.center,
            padding:  const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            margin: const EdgeInsets.only(bottom: 150),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 24,
                color: isListening ?Colors.black87:Colors.black54,
                fontWeight: FontWeight.w600
              ),
            ),
        ),
      ),
    );
  }
}
