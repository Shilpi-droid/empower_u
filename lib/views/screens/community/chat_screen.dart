
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../controllers/community_controller.dart';
import '../../constants/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ChatScreen extends StatefulWidget {
   ChatScreen({Key? key,required this.communityId,required this.username}) : super(key: key);

  final String communityId;
  final String username;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final CommunityController _communityController = Get.find();

 // Pass the community ID to the screen
   final TextEditingController _messageController = TextEditingController();

  bool containsProfanity(String input) {
    List<String> profanityList = [
      'arsehole',
      'asshat',
      'asshole',
      'b',
      'big black cock',
      'bitch',
      'bloody',
      'blowjob',
      'bugger',
      'bullshit',
      'chicken shit',
      'clusterfuck',
      'cock',
      'cocksucker',
      'coonass',
      'cornhole',
      'cox–zucker machine',
      'cracker',
      'cunt',
      'dafuq',
      'damn',
      'dick',
      'enshittification',
      'faggot',
      'feck',
      'fuck',
      'fuck her right in the pussy',
      'fuck joe biden',
      'fuck, marry, kill',
      'fuckery',
      'grab \'em by the pussy',
      'healslut',
      'motherfucker',
      'nigga',
      'nigger',
      'paki',
      'poof',
      'poofter',
      'prick',
      'pussy',
      'ratfucking',
      'retard',
      'russian warship, go fuck yourself',
      'shit',
      'shit happens',
      'shithouse',
      'shitter',
      'shut the fuck up',
      'shut the hell up',
      'slut',
      'son of a bitch',
      'spic',
      'twat',
      'wanker',
      'whore'
    ];

    for (String profanity in profanityList) {
      if (input.toLowerCase().contains(profanity)) {
        return true;
      }
    }

    return false;
  }


  // Future<bool> checkForAbuse(String message) async {
  //   print("lalalalalalalalalalalalalalalalalalalalala");
  //   final url = Uri.parse('http://uhack.pythonanywhere.com/check_string'); // Replace with your API endpoint URL
  //   bool abuse=false;
  //   final Map<String, dynamic> requestBody = {
  //     'text': message,
  //   };
  //
  //   final headers = {'Content-Type': 'application/json'};
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: headers,
  //       body: jsonEncode(requestBody),
  //     );
  //
  //     abuse=jsonDecode(response.body)['result'];
  //     if (response.statusCode == 200) {
  //
  //       print('Response data: ${jsonDecode(response.body)}');
  //
  //     } else {
  //       print('Error: ${response.statusCode}');
  //       print('Response data: ${response.body}');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  //   return abuse;
  // }


  void _sendMessage() async {
    final String messageContent = _messageController.text;
    if(await containsProfanity(messageContent))
      {
        final snackBar = SnackBar(
          content: Text('You cant use abusive language in this community', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
else {
      if (messageContent.isNotEmpty) {
        final String userId = FirebaseAuth.instance.currentUser?.uid ??
            ''; // Get the UID

        FirebaseFirestore.instance
            .collection(
            'users') // Assuming your users collection is named 'users'
            .doc(userId)
            .get()
            .then((docSnapshot) {
          if (docSnapshot.exists) {
            final String sender = docSnapshot['name'] as String; // Get the user's name

            final Timestamp currentTime = Timestamp.now();

            print("sender: $sender");
            print("sender: $messageContent");
            print("sender: $currentTime");
            FirebaseFirestore.instance
                .collection('communities')
                .doc(widget
                .communityId) // Assuming communityId is passed to the ChatScreen
                .collection('messages')
                .add({
              'username': sender,
              'message': messageContent,
              'timestamp': currentTime,
            });

            _messageController.clear();
          } else {
            print('User not found in Firestore');
          }
        });
      }
    }
    scrollToBottom();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollToBottom();
  }
  ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return

      Scaffold(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
                children:[
                Expanded (
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${widget.communityId}",
                          style: TextStyle(
                        fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.black
                      )
                      ),

                    ]
                  ),
                )),
                const CircleAvatar(
                backgroundColor: btnColor,
                child: Icon(Icons.video_call,color: Colors.white),),
                  10.widthBox,
                const CircleAvatar(
                backgroundColor: btnColor,
                  child: Icon(Icons.call,color: Colors.white),

    )

      ],
    ),
          ),
          30.heightBox,
          Expanded(
            child:
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _communityController.getChatMessagesStream(widget.communityId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final messages = snapshot.data ?? [];

                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  // Call scrollToBottom here to scroll to the bottom after messages are loaded
                  scrollToBottom();
                });
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final username = message['username'] as String; // Fetch sender's username from the message
                    final content = message['message'] as String; // Fetch message content


                    return  Directionality(
                            textDirection: widget.username==username? TextDirection.rtl:TextDirection.ltr,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8),
                              child:
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: widget.username==username?bgColor:btnColor,
                                    child: Icon(Icons.person,color: Colors.white,size:40),
                                  ),
                                  20.widthBox,
                                  Column(
                                    crossAxisAlignment: widget.username==username?CrossAxisAlignment.end:CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: username.text.gray500.make(),
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: width*.6, // Set the maximum width constraint
                                        ),
                                        child: Directionality(
                                          textDirection: TextDirection.ltr  ,
                                          child: Container(
                                              padding:const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: widget.username==username?bgColor:btnColor,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child:
                                              Directionality(
                                                textDirection:TextDirection.ltr,
                                                child:content.text.semiBold.white.make(),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // 20.widthBox,
                                  // Directionality(
                                  //   textDirection: TextDirection.ltr,
                                  //   child: "11:00 AM".text.gray500.size(12).make(),
                                  // )
                                ],
                              ),
                            ),
                          );

                    //   ListTile(
                    //   title: Text(username), // Display sender's username
                    //   subtitle: Text(content),
                    // );
                  },
                );
              },
            )

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
                      controller: _messageController,
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
                      onPressed: _sendMessage,
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
  void scrollToBottom() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 10),
        curve: Curves.easeOut,
      );
    });
  }
}









