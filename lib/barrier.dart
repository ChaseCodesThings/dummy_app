import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final barrierWidth;
  final barrierHeight;
  final barrierX;
  final barrierText;
  //final barrierLocation;
  final bool isThisBottomBarrier;

  MyBarrier({
    this.barrierHeight,
    this.barrierWidth,
    this.barrierX,
    this.barrierText,
    required this.isThisBottomBarrier,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(barrierX ,isThisBottomBarrier ? 1 : -1),
      child: Container(
        color: isThisBottomBarrier ? Colors.blue[900] : Colors.orange,
          width: MediaQuery.of(context).size.width * (barrierWidth / 2),
          height: MediaQuery.of(context).size.height * (3/4) * (barrierHeight / 2),
        child: Text(
          barrierText,
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }
}
