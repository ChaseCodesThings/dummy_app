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

enum direction{UP, DOWN, LEFT, RIGHT}

class _GameState extends State<Game>{
  //player variables
  double playerX = 0;
  double playerWidth = 0.4;
  //AI variables

  // ball variables
  double ballX = 0.0;
  double ballY = 0.0;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;
  //game settings
  bool gameStarted = false;
  void startGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      //update direction
      updateDirection();
      //move ball
      moveBall();
      //check if Game is over
      if (isGameOver()) {
        timer.cancel();
        _showDialog();
      }
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.purpleAccent,
            title: Center(
              child: Text(
                "AI WON",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.purpleAccent[100],
                    child: Text(
                      "PLAY AGAIN",
                      style: TextStyle(color: Colors.purpleAccent[800])
                    ),
                  ),
                ),
              )
            ],
          );
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      gameStarted = false;
      ballX = 0;
      ballY = 0;
      playerX = -0.2;
    });
  }

  bool isGameOver() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void updateDirection() {
    setState(() {
      //update vertical direction
      if (ballY >= 0.9 && playerX + playerWidth >= ballX && playerX <= ballX) {
        ballYDirection = direction.UP;
      }
      else if (ballY <= -0.9) {
        ballYDirection = direction.DOWN;
      }
      //update horizontal direction
      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      }
      else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }
  void moveBall() {

    //vertical movement
    setState(() {
      if (ballYDirection == direction.DOWN) {
        ballY += 0.005;
      }
      else if (ballYDirection == direction.UP) {
        ballY -= 0.005;
      }
      //horizontal movement
      if (ballXDirection == direction.LEFT) {
        ballX -= 0.005;
      }
      else if (ballXDirection == direction.RIGHT) {
        ballX += 0.005;
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
                Brick(
                    x: -0.2,
                    y: -0.9,
                    brickWidth: playerWidth,
                ),
                //bottom brick
                Brick(
                    x: playerX,
                    y: 0.9,
                    brickWidth: playerWidth,
                ),
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