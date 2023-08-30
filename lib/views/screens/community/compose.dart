
import 'package:empower_u/controllers/services.dart';
import 'package:empower_u/views/constants/strings.dart';
import 'package:empower_u/views/screens/community/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        title: "New Message".text.semiBold.make(),
        elevation: 0.0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          color: Colors.white
        ),
        child: StreamBuilder(
          stream: StoreServices.getAllUsers(),
          builder: (BuildContext context,AsyncSnapshot snapshot)
          {
            if(!snapshot.hasData)
              {
                return Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(bgColor),
                ),);
              }
            else{
              return GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 150,
                ),
                children: snapshot.data.docs.map<Widget>((document){
                  // var doc=snapshot.data!.docs[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center ,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                child: Icon(Icons.person,color: btnColor,size: 45,),
                              ),
                              Text(document.get('name'))
                            ],
                          ),
                          10.heightBox,
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(12),
                                  primary: bgColor
                              ),
                              onPressed: (){
                                // Get.to(()=>ChatScreen(user:document.get('name')),transition: Transition.downToUp);
                              },
                              icon: Icon(Icons.message,color: Colors.white,),
                              label: "Message".text.white.make(),

                            ),
                          )
                        ],
                      ),

                      // child: "${doc['name']}".text.make(),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
