import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/strings.dart';

Widget tabbar()
{
  return const RotatedBox(
    quarterTurns: 3,
    child: TabBar(
      labelColor: Colors.white,
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold
      ),
      indicator: BoxDecoration(),
      unselectedLabelColor: Vx.gray500,
      tabs:[
        Tab(text: chats,),
        Tab(text: status,),
        Tab(text: camera,),
      ]
    ),
  );
}