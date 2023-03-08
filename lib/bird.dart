import 'package:dummy_app/SizeConfig.dart';
import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final birdY;
  final double birdWidth;
  final double birdHeight;

  MyBird({this.birdY, required this.birdWidth, required this.birdHeight});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      alignment: Alignment(0, birdY),
      child: Image.asset(
        'assets/flappybird.png',
        width: SizeConfig.safeBlockVertical * 6,
        height: SizeConfig.safeBlockVertical * 6,
        fit: BoxFit.fill,
      ),
    );
  }
}
//width: MediaQuery.of(context).size.width * birdWidth,
//         height: MediaQuery.of(context).size.height * (3/4) * (birdHeight / 2),
