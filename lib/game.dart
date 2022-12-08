import 'dart:async';

import 'package:flutter/material.dart';
import 'ball.dart';
import 'brick.dart';
import 'coverscreen.dart';
class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}
class _GameState extends State<Game>{
  // ball variables
  double ballX = 0.0;
  double ballY = 0.0;

  //game settings
  bool gameStarted = false;
  void StartGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(() {
        ballY +=0.01;
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: Stack(
          children: [
            //tap to play
            CoverScreen(),
            //top brick
            Brick(x: 0.0, y: -0.9),
            //bottom brick
            Brick(x: 0.0, y: 0.9),
            //ball
            Ball(x: ballX, y: ballY),
          ],
        ),
      ),
    );
  }
}