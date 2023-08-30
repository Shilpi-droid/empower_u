import 'package:empower_u/views/screens/chatbot/bot_screen.dart';
import 'package:empower_u/views/screens/community/communities_list.dart';
import 'package:flutter/material.dart';

import 'chat_component.dart';

Widget tabbarview(String username)
{
  return Expanded(

    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft:   Radius.circular(12),
        )
      ),
      child: TabBarView(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft:   Radius.circular(12),
                  )
              ),
              child:CommunityListScreen(username: username,)

              // Container()
             // chatsComponent(),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft:   Radius.circular(12),
                  )
              ),
              child: BotScreen(),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft:   Radius.circular(12),
                  )
              ),
            )
          ]
      ),
    ),
  );
}