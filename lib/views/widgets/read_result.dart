
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ReadResult extends StatefulWidget {
  const ReadResult({Key? key,required this.text}) : super(key: key);

  final String text;

  @override
  State<ReadResult> createState() => _ReadResultState();
}

class _ReadResultState extends State<ReadResult> {
  Future<void> speakLabel(String text) async {

    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);

  }
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    speakLabel(widget.text);
  }

  @override
  void dispose()
  {
    flutterTts.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text(widget.text),
      ),
    );
  }
}


