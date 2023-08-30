import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/strings.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {super.key,
        required this.text,
        required this.sender,
        this.isImage = false});

  final String text;
  final String sender;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: sender=="user"?bgColor:btnColor,
            child: Icon(Icons.person,color: Colors.white,size:30),
          ),
          10.widthBox,
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: width*.6, // Set the maximum width constraint
            ),
            child: Directionality(
              textDirection: TextDirection.ltr  ,
              child: Container(
                  padding:const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: sender=="user"?bgColor:btnColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                  Directionality(
                    textDirection:TextDirection.ltr,
                    child:text.text.semiBold.white.make(),
                  )),
            ),
          ),
          // 20.widthBox,
          // Directionality(
          //   textDirection: TextDirection.ltr,
          //   child: "11:00 AM".text.gray500.size(12).make(),
          // )
        ],
      ),
    );


    //   Row(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Text(sender)
    //         .text
    //         .subtitle1(context)
    //         .make()
    //         .box
    //         .color(sender == "user" ? Vx.red200 : Vx.green200)
    //         .p16
    //         .rounded
    //         .alignCenter
    //         .makeCentered(),
    //     Expanded(
    //       child: isImage
    //           ? AspectRatio(
    //         aspectRatio: 16 / 9,
    //         child: Image.network(
    //           text,
    //           loadingBuilder: (context, child, loadingProgress) =>
    //           loadingProgress == null
    //               ? child
    //               : const CircularProgressIndicator.adaptive(),
    //         ),
    //       )
    //           : text.trim().text.bodyText1(context).make().px8(),
    //     ),
    //   ],
    // ).py8();
  }
}
