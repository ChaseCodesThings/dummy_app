import 'package:dummy_app/bird.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class FlappyBird extends StatefulWidget {

  @override
  State<FlappyBird> createState() => _FlappyBirdState();
}

enum direction{UP}

class _FlappyBirdState extends State<FlappyBird> {
  //bird variables
  static double birdY = 0;
  static double birdWidth = 0;
  static double birdHeight = 0;
  double initialPosition = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 3.5;

  //game settings
  bool gameHasStarted = false;

  //barrier variables
  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];
  void startGame() {
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      height = (gravity * time * time) + (velocity * time);

      setState(() {
        birdY = initialPosition - height;
      });

      if (birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }

      time += 0.1;
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                "G A M E  O V E R",
                style: TextStyle(color: Colors.white,),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                        "PLAY AGAIN",
                        style: TextStyle(color: Colors.brown)
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPosition = birdY;
    });
  }

  bool birdIsDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Stack(
                      children: [
                        MyBird(
                          birdY: birdY,
                          birdWidth: birdWidth,
                          birdHeight: birdHeight,
                        ),
                        Container(
                          alignment: Alignment(0, -0.5),
                          child: Text(
                            gameHasStarted ? '' : 'T A P  T O  P L A Y',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ),
            Expanded(
                child: Container(
                  color: Colors.brown,
                )
            ),
          ],
        ),
      ),
    );
  }
}

