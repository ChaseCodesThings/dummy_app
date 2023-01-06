import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final barrierWidth;
  final barrierHeight;
  final barrierX;
  final barrierText;
  //final barrierLocation;
  final bool isThisBottomBarrier;
  final bool rightWord;

  MyBarrier({
    this.barrierHeight,
    this.barrierWidth,
    this.barrierX,
    this.barrierText,
    required this.isThisBottomBarrier,
    required this.rightWord,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(barrierX ,isThisBottomBarrier ? 1 : -1),
      child: Container(
        color: isThisBottomBarrier ? Colors.blue[900] : Colors.orange,
          width: MediaQuery.of(context).size.width * (barrierWidth / 2),
          height: MediaQuery.of(context).size.height * (3/4) * (barrierHeight / 2),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            barrierText,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
