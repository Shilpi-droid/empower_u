
import 'package:empower_u/views/screens/community/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constants/strings.dart';

Widget chatsComponent() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
  child: ListView.builder(
  itemCount: 20,
  itemBuilder: (BuildContext context,int index) {
    return
      Card(
        child: ListTile(
          onTap: ()=>{
            // Get.to(()=>ChatScreen(),transition: Transition.downToUp),
          },
          leading: CircleAvatar(
              radius: 25,
              backgroundColor: bgColor,
              child: Icon(Icons.person, color: Colors.white,size: 40,)), // CircleAvatar
          title: "Dummy Name".text
              .size(16)
              .semiBold
              .make(),
          subtitle: "Message here..".text.make(),
          trailing: "Last seen".text.gray400.make(),

        ),
      );
  })
  );
}