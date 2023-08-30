
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/strings.dart';
import '../../widgets/three_dots.dart';
import 'bot_message.dart';

class BotScreen extends StatefulWidget {
  const BotScreen({Key? key}) : super(key: key);

  @override
  State<BotScreen> createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {

  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  late OpenAI? chatGPT;
  bool _isImageSearch = false;

  bool _isTyping = false;

  // @override
  // void initState() {
  //   chatGPT = OpenAI.instance.build(
  //       token: dotenv.env["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"],
  //       baseOption: HttpSetup(receiveTimeout: Duration(milliseconds: 60000)));
  //   if (chatGPT != null) {
  //     print("chatGPT instance initialized successfully");
  //   } else {
  //     print("chatGPT instance initialization failed");
  //   }
  //
  //   super.initState();
  // }

  @override
  void initState() {
    final token = "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";
        //"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";

    try {
      chatGPT = OpenAI.instance.build(
        token: token,
        baseOption: HttpSetup(receiveTimeout: Duration(milliseconds: 600)),
      );
      print("chatGPT instance initialized successfully");
    } catch (e) {
      print("chatGPT instance initialization failed: $e");
      // Handle the exception accordingly
    }

    super.initState();
  }


  @override
  void dispose() {
    // chatGPT?.close();
    // chatGPT?.genImgClose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    ChatMessage message = ChatMessage(
      text: _controller.text,
      sender: "user",
      isImage: false,
    );

    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    _controller.clear();

    if (_isImageSearch) {
      final request = GenerateImage(message.text, 1, size: ImageSize.size256);

      final response = await chatGPT!.generateImage(request);
      Vx.log(response!.data!.last!.url!);
      insertNewData(response.data!.last!.url!, isImage: true);
    } else {
      final request =
      CompleteText(prompt: message.text, model: TextDavinci3Model());

      final response = await chatGPT!.onCompletion(request: request);
      Vx.log(response!.choices[0].text);
      insertNewData(response.choices[0].text, isImage: false);
    }
  }

  void insertNewData(String response, {bool isImage = false}) {
    ChatMessage botMessage = ChatMessage(
      text: response,
      sender: "bot",
      isImage: isImage,
    );

    setState(() {
      _isTyping = false;
      _messages.insert(0, botMessage);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar:  AppBar(
            backgroundColor: Colors. transparent,
            elevation: 0.0,
            actions: const [
              Icon (
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
            ]
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical:8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular (16)),
            ),
            child: Column(
                children: [
                  Flexible(
                      child: ListView.builder(
                        reverse: true,
                        padding: Vx.m8,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          return _messages[index];
                        },
                      )),
                  if (_isTyping) const ThreeDots(),
                  const Divider(
                    height: 1.0,
                  ),
                  10.heightBox,
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextFormField(
                            controller: _controller,
                            // onSubmitted: (value) => _sendMessage(),
                            // maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.emoji_emotions,color: Colors.grey,),
                                border: InputBorder.none,
                                hintText: "Type message here...",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.grey,)
                            ),
                          ),
                        )),
                        20.widthBox,
                        CircleAvatar(
                          backgroundColor: btnColor,
                          child: IconButton
                            (
                              onPressed: (){
                                _sendMessage();
                              },
                              icon:Icon(Icons.send, color:Colors.white)),
                        )
                      ],
                    ),
                  )
                ]
            )
        )
    );
  }
}
