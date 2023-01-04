import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {

  final birdY;
  final double birdWidth;
  final double birdHeight;

  MyBird({this.birdY, required this.birdWidth, required this.birdHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, ((2 * birdY + birdHeight) / (2 - birdHeight)) + 0.5),
      child: Image.asset('assets/flappybird.png',
        width: 150,
        height: 150,
        fit: BoxFit.fill,
      ),
    );
  }
}
//width: MediaQuery.of(context).size.width * birdWidth,
//         height: MediaQuery.of(context).size.height * (3/4) * (birdHeight / 2),