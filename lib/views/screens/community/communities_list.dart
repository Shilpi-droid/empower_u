import 'package:empower_u/views/screens/community/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controllers/community_controller.dart';
import '../../constants/strings.dart';
import 'create_community_popup.dart';

class CommunityListScreen extends StatelessWidget {
  final CommunityController _communityController = Get.find();

  final String username;

  CommunityListScreen({super.key, required this.username});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor:bgColor,
        onPressed: (){
          Get.dialog(CommunityNamePopup());
          // Get.to(()=>ComposeScreen(),transition: Transition.downToUp);
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body: FutureBuilder<List<String>>(
        future: _communityController.fetchCommunityNames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No communities found.'));
          }

          final communityNames = snapshot.data!;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              itemCount: communityNames.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: ()=>{
                   _communityController.joinCommunity(communityNames[index]),
                   //  String communityId = await _communityController.joinCommunity(communityNames[index]);
                      Get.to(()=>ChatScreen(communityId:communityNames[index],username: username,),transition: Transition.downToUp),
                    },
                    leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: bgColor,
                        child: Icon(Icons.person, color: Colors.white,size: 40,)), // CircleAvatar
                    title: communityNames[index].text
                        .size(16)
                        .semiBold
                        .make(),
                    subtitle: "Message here..".text.make(),
                    // trailing: IconButton(
                    //     onPressed: () {
                    //       _communityController.joinCommunity(communityNames[index]);
                    //     },
                    //     icon:Icon(Icons.arrow_forward_ios),
                    // ),

                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
