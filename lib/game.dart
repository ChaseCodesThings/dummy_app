import 'dart:async';

import 'package:flutter/material.dart';
import 'ball.dart';
import 'brick.dart';
import 'coverscreen.dart';
class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

enum direction{UP, DOWN}

class _GameState extends State<Game>{
  // ball variables
  double ballX = 0.0;
  double ballY = 0.0;
  var ballDirection = direction.DOWN;
  //game settings
  bool gameStarted = false;
  void startGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(() {
        ballY += 0.01;
      });
      //update direction
      updateDirection();
      //move ball
      moveBall();
    });
  }
  void updateDirection() {
    if (ballY >= 0.9) {
      ballDirection = direction.DOWN;
    }
    else if (ballY <= -0.9) {
      ballDirection = direction.UP;
    }
  }
  void moveBall() {
    setState(() {
      if (ballDirection == direction.DOWN) {
        ballY += 0.01;
      }
      else if (ballDirection == direction.UP) {
        ballX -= 0.01;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: startGame,
      child: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: Center(
          child: Stack(
            children: [
              //tap to play
              CoverScreen(gameStarted: gameStarted,),
              //top brick
              Brick(x: 0.0, y: -0.9),
              //bottom brick
              Brick(x: 0.0, y: 0.9),
              //ball
              Ball(x: ballX, y: ballY),
            ],
          ),
        ),
      ),
    );
  }
}