import 'package:flutter/material.dart';

class Brick extends StatelessWidget{
  final x;
  final y;
  final brickWidth;
  final thisIsEnemy;
  Brick({this.x, this.y, this.brickWidth, this.thisIsEnemy});
  @override
  Widget build(BuildContext context) {
    //(((2 * x) + brickWidth)/(2 - brickWidth))
    return Container(
      alignment: Alignment((((2 * x) + brickWidth)/(2 - brickWidth)), y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: thisIsEnemy ? Colors.red : Colors.white,
          height: 20,
          width: MediaQuery.of(context).size.width / 4,
        ),
      ),
    );
  }
}