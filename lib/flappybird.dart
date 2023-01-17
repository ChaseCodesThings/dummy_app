//change barrier, add list of englsih words and their spanish pairs, add text box to display english words
// add boolean to test wheter bird is inside barrier(make it true) then chnage it back to false when bird is outside barrier

//display an english word, display a correctly translated spanish word, display an incorrectly translated spanish word
// if bird chooses wrong translation, the game stops
//what barrier is right must alternate between different sets
//if bird chooses right translation: the score is increased by 1, the english word and its two translations are switched for a different set

import 'package:dummy_app/barrier.dart';
import 'package:dummy_app/bird.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:translator/translator.dart';
import 'dart:math';

class FlappyBird extends StatefulWidget {

  @override
  State<FlappyBird> createState() => _FlappyBirdState();
}

enum direction{UP}

class _FlappyBirdState extends State<FlappyBird> {
  //bird variables
  static double birdY = 0;
  static double birdWidth = 0.1;
  static double birdHeight = 0.1;
  double initialPosition = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 2.9;

  //game settings
  bool gameHasStarted = false;
  int score = 0;
  //barrier variables
  GoogleTranslator translator = GoogleTranslator();
  static List<double> barrierX = [1, 2.5, 4];
  static List<List<String>> vocab = [
    ['dog', 'perro', 'gato'],//top
    ['cat', 'perro', 'gato'],//bottom
    ['red', 'azul', 'rojo'],//bottom
    ['blue', 'azul', 'rojo'],//top
    ['hot', 'frio', 'caliente'],//bottom
    ['cold', 'frio', 'caliente']//top
  ];

  String engWord = vocab[0][0];
  String spnWord1 = vocab[0][1];
  String spnWord2 = vocab[0][2];
  static double barrierWidth = 0.5;
  static double barrierHeight = 0.75;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      time += 0.005;
      height = (gravity * time * time) + (velocity * time);
      setState(() {
        birdY = initialPosition - height;
        for (int i = 0; i < barrierX.length; i++) {
          barrierX[i] -= 0.005;
          if (barrierX[i] < -1.6) {
            barrierX[i] += 3;
          }
        }
        if (barrierX[score] < -0.5) {
              score++;
              engWord = vocab[score][0];
              spnWord1 = vocab[score][1];
              spnWord2 = vocab[score][2];
          }
        //print(engWord);
        //print(spnWord1);
        //print(spnWord2);
      });

      if (birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }

    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      barrierX = [1, 2.5, 4];
      height = (gravity * time * time) + (velocity * time);
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

  bool topRightWord() {
    if (engWord.translate(to: 'es') == spnWord1) {
      return true;
    }
    return false;
  }

  bool birdIsDead() {
    if ((birdY < -1 || birdY > 1) && (!topRightWord() && ((barrierX[score] <= birdWidth && barrierX[score] + barrierWidth >= -birdWidth) && (birdY > barrierHeight )))) {
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

                        //top barrier 1
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight,
                          barrierText: spnWord1,
                          isThisBottomBarrier: false,
                        ),
                        //bottom barrier 1
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight,
                          barrierText: spnWord2,
                          isThisBottomBarrier: true,
                        ),
                        //top barrier 2
                        MyBarrier(
                          barrierX: barrierX[1],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight,
                          barrierText: spnWord1,
                          isThisBottomBarrier: false,
                        ),
                        //bottom barrier 2
                        MyBarrier(
                          barrierX: barrierX[1],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight,
                          barrierText: spnWord2,
                          isThisBottomBarrier: true,
                        ),
                        //top barrier 3
                        MyBarrier(
                          barrierX: barrierX[2],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight,
                          barrierText: spnWord1,
                          isThisBottomBarrier: false,
                        ),
                        //bottom barrier 3
                        MyBarrier(
                          barrierX: barrierX[2],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight,
                          barrierText: spnWord2,
                          isThisBottomBarrier: true,
                        ),
                      ],
                    ),
                  ),
                )
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('English Word', style: TextStyle(color: Colors.white, fontSize: 30)),
                          SizedBox(height: 20),
                          Text(engWord, style: TextStyle(color: Colors.white, fontSize: 30)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('SCORE', style: TextStyle(color: Colors.white, fontSize: 30)),
                          SizedBox(height: 20),
                          Text('${score}', style: TextStyle(color: Colors.white, fontSize: 30)),
                        ],
                      ),
                      /*Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('BEST', style: TextStyle(color: Colors.white, fontSize: 30)),
                          SizedBox(height: 20, width: 20,),
                          Text('0', style: TextStyle(color: Colors.white, fontSize: 30)),
                        ],
                      ),*/
                  ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}