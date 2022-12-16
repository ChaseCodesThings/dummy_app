import 'dart:async';
import 'package:dummy_app/scorescreen.dart';
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
  //player variables (bottom brick)
  double playerX = 0;
  double brickWidth = 0.4;
  double playerScore = 0;

  //enemy variables (top brick)
  double enemyX = 0;
  double enemyScore = 0;

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

      //move enemy
      moveEnemy();

      //check if player has lost
      if (playerHasLost()) {
        enemyScore++;
        timer.cancel();
        _showDialog(false);
      }

      //check if enemy has lost
      if (enemyHasLost()) {
        playerScore++;
        timer.cancel();
        _showDialog(true);
      }
    });
  }

  void moveEnemy() {
    setState(() {
      if (ballXDirection == direction.LEFT) {
        enemyX -= 0.00035;
      }
      else if (ballXDirection == direction.RIGHT) {
        enemyX += 0.00035;
      }
    });
  }

  void _showDialog(bool enemyDied) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: enemyDied? Colors.white : Colors.red,
            title: Center(
              child: Text(
                enemyDied ? "YOU WON" : "ENEMY WON",
                style: TextStyle(color: enemyDied? Colors.black : Colors.white,),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: enemyDied? Colors.white : Colors.red,
                    child: Text(
                      "PLAY AGAIN",
                      style: TextStyle(color: enemyDied? Colors.black : Colors.white)
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
      playerX = 0;
      enemyX = 0;
    });
  }

  bool playerHasLost() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  bool enemyHasLost() {
    if (ballY <= -1) {
      return true;
    }
    return false;
  }

  void updateDirection() {
    setState(() {
      //update vertical direction
      if (ballY >= 0.9 && playerX + brickWidth >= ballX && playerX <= ballX) {
        ballYDirection = direction.UP;
      }
      else if (ballY <= -0.9 && enemyX + brickWidth >= ballX && playerX <= ballX) {
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
      if (!(playerX - 0.1 <= -1)) {
        playerX -= 0.1;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + 0.1 >= 0.7)) {
        playerX += 0.1;
      }
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
          backgroundColor: Colors.grey[800],
          body: Center(
            child: Stack(
              children: [
                //tap to play
                CoverScreen(gameStarted: gameStarted,),

                //score screen
                ScoreScreen(
                  gameStarted: gameStarted,
                  enemyScore: enemyScore.round(),
                  playerScore: playerScore.round(),
                ),

                //top brick
                Brick(
                    x: enemyX,
                    y: -0.9,
                    brickWidth: brickWidth,
                    thisIsEnemy: true,
                ),

                //bottom brick
                Brick(
                    x: playerX,
                    y: 0.9,
                    brickWidth: brickWidth,
                    thisIsEnemy: false,
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