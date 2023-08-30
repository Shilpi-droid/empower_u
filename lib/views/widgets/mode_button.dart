import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ModeButton extends StatefulWidget {

  const ModeButton({Key? key,required this.text,required this.page}) : super(key: key);

  final String text;
  final Widget page;
  @override
  State<ModeButton> createState() => _ModeButtonState();
}

class _ModeButtonState extends State<ModeButton> {

  Future<void> speakLabel(String text) async {

    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);

  }

  final FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        speakLabel(widget.text);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => widget.page));
      },
      child: Container(
        width: width*.74,
        height: height*.15,
        decoration: BoxDecoration(
          color: Color(0xff83BD6F) ,
          //Colors.white.withOpacity(.2),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
            topLeft: Radius.circular(50),
          ),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 25
            ),
          ),
        ),
      ),
    );
  }
}