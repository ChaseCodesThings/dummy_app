import 'package:dummy_app/barrier.dart';
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
  static double birdWidth = 0.1;
  static double birdHeight = 0.1;
  double initialPosition = birdY;
  double height = 0;
  double time = 0;
  double gravity = -3.5;
  double velocity = 2.9;

  //game settings
  bool gameHasStarted = false;
  int score = 0;
  //barrier variables
  static List<double> barrierX = [1, 3];
  static List<List<String>> vocab = [
    ['dog', 'perro', 'gato', 'perro'],//top
    ['cat', 'perro', 'gato', 'gato'],//bottom
    ['red', 'azul', 'rojo', 'rojo'],//bottom
    ['blue', 'azul', 'rojo', 'azul'],//top
    ['hot', 'frio', 'caliente', 'caliente'],//bottom
    ['cold', 'frio', 'caliente', 'frio'],//top
    ['water', 'fuego', 'aqua', 'aqua'],//bottom
    //['fire', 'aqua', 'fuego', 'fuego']//bottom
  ];
  String engWord = vocab[0][0];

  String spnWord1 = vocab[0][1];
  String spnWord2 = vocab[0][2];
  String corWord = vocab[0][3];
  static double barrierWidth = 0.5;
  //static double barrierHeight = MediaQuery.of(context).size.width/554;



  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      time += 0.005;
      height = (gravity * time * time) + (velocity * time);
      setState(() {
        birdY = initialPosition - height;
        for (int i = 0; i < barrierX.length; i++) {
          barrierX[i] -= 0.005;
          if ((barrierX[i] < -1.6) && (score < vocab.length - 1)) {
            barrierX[i] += 4;
          }
        }
        if ((barrierX[score % barrierX.length] <= -0.7) && (score < (vocab.length - 1))) {
              score++;
              engWord = vocab[score][0];
              spnWord1 = vocab[score][1];
              spnWord2 = vocab[score][2];
              corWord = vocab[score][3];
          }
        if ((barrierX[score % barrierX.length] <= -0.7) && (score == (vocab.length - 1))) {
          score++;
        }
      });
      if (birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
        print(MediaQuery.of(context).size.width);
        print(MediaQuery.of(context).size.height);
      }
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
       gameHasStarted = false;
       score = 0;
      //barrier variables
       barrierX = [1, 3];
       engWord = vocab[0][0];
       spnWord1 = vocab[0][1];
       spnWord2 = vocab[0][2];
       corWord = vocab[0][3];
        birdY = 0;
       initialPosition = birdY;
        time = 0;
        height = (gravity * time * time) + (velocity * time);
    });
  }

  bool topRightWord() {
    if (spnWord1 == corWord) {
      return true;
    }
    return false;
  }
  bool wonTheGame() {
    if (score == vocab.length) {
      return true;
    }
    return false;
  }

  bool birdIsDead() {
    if ((wonTheGame()) || (((birdY <= (MediaQuery.of(context).size.height/-235.1)) || (birdY >= (MediaQuery.of(context).size.width/411.43)))) || ((!topRightWord()) && (barrierX[score % barrierX.length] <= birdWidth && barrierX[score % barrierX.length] + barrierWidth >= -birdWidth) && (birdY <= (MediaQuery.of(context).size.width/-1150))) || ((topRightWord()) && (barrierX[score % barrierX.length] <= birdWidth && barrierX[score % barrierX.length] + barrierWidth >= -birdWidth) && (birdY >= (MediaQuery.of(context).size.width/-1150)))) {
      return true;
    }
    return false;
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            backgroundColor: wonTheGame() ? Colors.orange: Colors.brown,
            title: Center(
              child: Text(
                wonTheGame() ? "C O N G R A T S" : "G A M E  O V E R",
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
                  color: Colors.grey[850],
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

                        //To Do
                        //top barrier 1
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: MediaQuery.of(context).size.height/3.578,
                          barrierText: spnWord1,
                          isThisBottomBarrier: false,
                        ),
                        //bottom barrier 1
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: MediaQuery.of(context).size.height/3.578,
                          barrierText: spnWord2,
                          isThisBottomBarrier: true,
                        ),
                        //top barrier 2
                        MyBarrier(
                          barrierX: barrierX[1],
                          barrierWidth: barrierWidth,
                          barrierHeight: MediaQuery.of(context).size.height/3.578,
                          barrierText: spnWord1,
                          isThisBottomBarrier: false,
                        ),
                        //bottom barrier 2
                        MyBarrier(
                          barrierX: barrierX[1],
                          barrierWidth: barrierWidth,
                          barrierHeight: MediaQuery.of(context).size.height/3.578,
                          barrierText: spnWord2,
                          isThisBottomBarrier: true,
                        ),
                      ],
                    ),
                  ),
                )
            ),
            Container(
              height: MediaQuery.of(context).size.height/57.8,
              color: Colors.green,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/5.38,
                  child: Container(
                    color: Colors.brown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('English Word', style: TextStyle(color: Colors.white, fontSize: 30)),
                            SizedBox(height: MediaQuery.of(context).size.height/40.5),
                            Text(engWord, style: TextStyle(color: Colors.white, fontSize: 30)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('SCORE', style: TextStyle(color: Colors.white, fontSize: 30)),
                            SizedBox(height: MediaQuery.of(context).size.height/40.5),
                            Text('${score}', style: TextStyle(color: Colors.white, fontSize: 30)),
                          ],
                        ),
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