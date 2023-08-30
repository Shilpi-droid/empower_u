import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  OptionTile({Key? key,
    required this.bgColor,
    required this.circColor,
    required this.txtColor,
    required this.icon,
    required this.text,
    required this.page
  }) : super(key: key);

  final Color bgColor;
  final Color circColor;
  final Color txtColor;
  final IconData icon;
  String text;
  final Widget page;
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return
      InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
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
                color: bgColor,
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
                    color: circColor
                ),
                child: Icon(icon,color: txtColor,size: height*.09,),
              ),
            ),
            Positioned(
                top: height*.15,
                width: height*.2,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: txtColor
                  ),
                )
            ),


          ]
      ),
    );
  }
}
