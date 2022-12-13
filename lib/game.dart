import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ball.dart';
import 'brick.dart';
import 'coverscreen.dart';
class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

enum direction{UP, DOWN}

class _GameState extends State<Game>{
  //player variables
  double playerX = 0;

  // ball variables
  double ballX = 0.0;
  double ballY = 0.0;
  var ballDirection = direction.DOWN;
  //game settings
  bool gameStarted = false;
  void startGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      //update direction
      updateDirection();
      //move ball
      moveBall();
    });
  }
  void updateDirection() {
    setState(() {
      if (ballY >= 0.9) {
        ballDirection = direction.UP;
      }
      else if (ballY <= -0.9) {
        ballDirection = direction.DOWN;
      }
    });
  }
  void moveBall() {
    //vertical movement
    setState(() {
      if (ballDirection == direction.DOWN) {
        ballY += 0.01;
      }
      else if (ballDirection == direction.UP) {
        ballY -= 0.01;
      }
    });
  }

  void moveLeft() {
    setState(() {
      playerX -= 0.1;
    });
  }

  void moveRight() {
    setState(() {
      playerX += 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        }
        else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
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
                Brick(x: playerX, y: 0.9),
                //ball
                Ball(x: ballX, y: ballY),
              ],
            ),
          ),
        ),
      ),
    );
  }
}