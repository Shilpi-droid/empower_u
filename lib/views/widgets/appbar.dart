import 'package:flutter/material.dart';

import '../constants/strings.dart';

Widget appbar(GlobalKey<ScaffoldState>key)
{
  return Container(
    padding: EdgeInsets.only(right:12),
    height: 80,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap:  ()
          {
            key.currentState!.openDrawer();
          },
          child: Container(
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                )
            ),
            height: 100,
            width: 90,
            child: const Icon(Icons.settings,color: Colors.white,),
          ),
        ),
        RichText(
            text:TextSpan(
                children:[
                  TextSpan(
                      text: "$appname\n",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black)
                  ),
                  TextSpan(
                      text: "                            $connectingLives",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black)
                  ),
                ]
            )
        ),
        CircleAvatar(
          backgroundColor: bgColor,
          radius: 25,
          child: Icon(Icons.person,color: Colors.white70,),
        )
      ],
    ),
  );
}