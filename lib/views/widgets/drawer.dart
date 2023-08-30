
import 'package:empower_u/views/screens/community/chat_screen.dart';
import 'package:empower_u/views/screens/community/profile_screen.dart';
import 'package:empower_u/views/screens/community/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/firebase_constants.dart';
import '../constants/strings.dart';

Widget drawer() {
  return Drawer(
    backgroundColor: bgColor,
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.horizontal(right: Radius.circular (25))
  ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
      child: Column(
        children: [
        ListTile(
        leading: const Icon(Icons.arrow_back_ios,color: Colors.white,).onTap((){
        Get.back();}),
        title: "Settings".text.bold.white.make()
        ),
          20. heightBox,
          const CircleAvatar(
            radius: 45,
            backgroundColor: Colors.orange,
            child: Icon(Icons.person,color: Colors.white,size: 70,),
          ),
          10. heightBox,
          "Username".text.white.semiBold.size(16).make(),
          const Divider (color: Colors.white, height: 0.5),
          10.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(drawerIconList.length, (index) => ListTile(
              onTap: ()
              {
                switch(index)
                {
                  case 0: Get.to(() => const ProfileScreen());
                      break;
                  default:
                }
              },
              leading: Icon(drawerIconList[index],color: Colors.white,),
              title: drawerListTitles[index].text.semiBold.white.make(),
            ),


            ),
          ),
          Spacer(),
          ListTile(
            onTap: () async{
              await auth.signOut();
              Get.offAll(()=>const VerificationScreen());
            },
            leading: Icon(Icons.logout,color: Colors.white,),
            title: "Logout".text.semiBold.white.make(),
          ),


  ]
  ),
    )
  );
}