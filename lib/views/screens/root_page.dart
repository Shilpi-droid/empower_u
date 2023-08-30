
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empower_u/views/constants/strings.dart';
import 'package:empower_u/views/screens/blind.dart';
import 'package:empower_u/views/screens/community/home_screen.dart';
import 'package:empower_u/views/screens/deaf.dart';
import 'package:empower_u/views/widgets/option_tile2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return  SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Color(0xff250E63),
          // ),
          // backgroundColor: Color(0xff2A2C28),
          backgroundColor: bgColor,
          //Color(0xff151413),
          body: Container(
            width: width,
            child: Column(
              children: [
                SizedBox(height: height*.155,),
                // OptionTile2(),
                OptionTile(
                  bgColor: Color(0xffffcf3c4),
                  // bgColor: Colors.brown,
                  //txtColor: Colors.brown,
                  circColor: Color(0xfffefae6),
                  txtColor: Color(0xfffcaf55),
                  icon: Icons.screen_search_desktop_outlined,
                  text: "Blindness",
                  page: Blind()
                ),
                SizedBox(height: height*.04,),
                OptionTile(
                  bgColor: Color(0xffd7efff),
                  circColor: Color(0xfff1f8fe),
                  txtColor: Color(0xff3a9df7),
                  icon: Icons.headset_mic_outlined,
                  text: "Deafness",
                  page: Deaf()
                ),
                SizedBox(height: height*.04,),

            InkWell(
              onTap: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => isUser?HomeScreen(username: username,):VerificationScreen(),
                  ),
                );
              },
              child: Stack(
                  children:[
                    Container(
                      height: height*.2,
                      width: height*.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffe1d6ff),
                        boxShadow: [
                          BoxShadow(
                            color:
                            //Colors.grey,
                            Color(0xff250E63),
                            spreadRadius: 1,
                            blurRadius: 9,
                            offset: Offset(0, 3), // horizontal and vertical offset
                          ),
                        ],
                        //border: Border.all(color: txtColor,width: 2)
                      ),
                    ),
                    Positioned(
                      left: width*.07,
                      top: height*.017,
                      child: Container(
                        height: height*.12,
                        width: height*.12,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xfff4f0fe),
                        ),
                        child: Icon(Icons.chat_bubble_outline,color: Color(0xff8a6df4),size: height*.09,),
                      ),
                    ),
                    Positioned(
                        top: height*.15,
                        width: height*.2,
                        child: Text(
                          "Community",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff8a6df4),
                          ),
                        )
                    ),


                  ]
              ),
            ),
                // OptionTile(
                //     bgColor: Color(0xffe1d6ff),
                //     circColor: Color(0xfff4f0fe),
                //     txtColor: Color(0xff8a6df4),
                //     icon: Icons.chat_bubble_outline,
                //     text: "Community",
                //     page: VerificationScreen()
                //   //ShowcaseTimelineTile(),//MemoryLane(),
                // ),
              ],
            ),
          ),
        ),
    );
  }
}
