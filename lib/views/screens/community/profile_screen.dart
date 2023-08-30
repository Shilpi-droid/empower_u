
import 'package:empower_u/views/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: "Profile".text.white.bold.make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all (12.0),
          child: Column(
            children: [
            CircleAvatar(
                radius: 80,
                backgroundColor: btnColor,
                child: Stack(
                children:[
                  Icon(Icons.person,color: Colors.white,size:150),
                  Positioned(
                    right: 0,
                    bottom: 20,
                    child: const CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  )
                ]
                )
                ),
              20.heightBox,
              const Divider(color: btnColor,),
              10.heightBox,
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: TextFormField(
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    label: "Name".text.make()
                  ),
                ),
                subtitle: namesub.text.white.make(),
              ),
              ListTile(
                leading: const Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                title: TextFormField(
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      label: "About".text.make(),
                    isDense: true,
                    labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)
                  ),
                ),
              ),

              ListTile(
                leading: const Icon(
                  Icons.call,
                  color: Colors.white,
                ),
                title: TextFormField(
                  readOnly: true,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      label: "Phone".text.make(),
                      isDense: true,
                      labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)
                  ),
                ),
              ),
      ])
          )
          );
  }
}
