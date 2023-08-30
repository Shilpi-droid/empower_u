
import 'package:empower_u/views/screens/speech_screen.dart';
import 'package:empower_u/views/screens/walking_mode.dart';
import 'package:flutter/material.dart';

import '../widgets/mode_button.dart';

class Deaf extends StatelessWidget {
  const Deaf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return  Scaffold(
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
                ModeButton(text: "Lecture Mode",page: SpeechScreen(),),
              ],
            ),
          )
        ],
      ),
    );

  }
}
