
import 'package:empower_u/views/widgets/hexagon.dart';
import 'package:flutter/material.dart';

class OptionTile2 extends StatelessWidget {
  const OptionTile2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Stack(
      children: [

        Container(
          color: Colors.blue,
          height: width*.35,
          width: width*.6,
        ),
        Container(
          width: width*.4,
          height: width*.4,
          child: CustomPaint(
            painter: HexagonPainter(),
            child: CustomPaint(
              painter: HexagonPainter(),
            ),
          ),
        ),
      ],
    );
  }
}
