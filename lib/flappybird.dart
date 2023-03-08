import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:dummy_app/SizeConfig.dart';
import 'package:dummy_app/barrier.dart';
import 'package:dummy_app/bird.dart';
import 'package:flutter/material.dart';

class FlappyBird extends StatefulWidget {
  @override
  State<FlappyBird> createState() => _FlappyBirdState();
}

enum direction { UP }

class _FlappyBirdState extends State<FlappyBird> {
  //bird variables
  static double birdY = 0;
  static double birdWidth = 0.05;
  static double birdHeight = 0.1;
  double initialPosition = birdY;
  double height = 0;
  double time = 0;
  double gravity = -3.0;
  double velocity = 2.5;

  //game settings
  bool gameHasStarted = false;
  int score = 0;
  //barrier variables
  static List<double> barrierX = [1, 4];
  static List<List<String>> vocab = [
    ['dog', 'perro', 'gato', 'perro'], //top
    ['cat', 'perro', 'gato', 'gato'], //bottom
    ['red', 'azul', 'rojo', 'rojo'], //bottom
    ['blue', 'azul', 'rojo', 'azul'], //top
    ['hot', 'frio', 'caliente', 'caliente'], //bottom
    ['cold', 'frio', 'caliente', 'frio'], //top
    ['water', 'fuego', 'aqua', 'aqua'], //top
    ['fire', 'aqua', 'fuego', 'fuego'] //bottom
  ];
  String engWord = vocab[0][0];

  String spnWord1 = vocab[0][1];
  String spnWord2 = vocab[0][2];
  String corWord = vocab[0][3];
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
          if ((barrierX[i] < -1) && (score < vocab.length - 1)) {
            barrierX[i] += 6;
          }
        }
        if ((barrierX[score % barrierX.length] <= -0.99) &&
            (score < (vocab.length - 1))) {
          score++;
          engWord = vocab[score][0];
          spnWord1 = vocab[score][1];
          spnWord2 = vocab[score][2];
          corWord = vocab[score][3];
        }
        if ((barrierX[score % barrierX.length] <= -0.7) &&
            (score == (vocab.length - 1))) {
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
      barrierX = [1, 4];
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
    if ((wonTheGame()) ||
        (((birdY <= -1) || (birdY >= 1))) ||
        ((!topRightWord()) &&
            (barrierX[score % barrierX.length] <= birdWidth &&
                barrierX[score % barrierX.length] >= -birdWidth) &&
            (birdY < 0.0)) ||
        ((topRightWord()) &&
            (barrierX[score % barrierX.length] <= birdWidth &&
                barrierX[score % barrierX.length] >= -birdWidth) &&
            (birdY > 0.0))) {
      _controller.play();
      return true;
    }
    return false;
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Stack(
            children: [
              AlertDialog(
                alignment: Alignment.center,
                backgroundColor: wonTheGame() ? Colors.orange : Colors.brown,
                title: Center(
                  child: Text(
                    wonTheGame() ? "C O N G R A T S" : "G A M E  O V E R",
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
                        child: Text("PLAY AGAIN",
                            style: TextStyle(color: Colors.brown)),
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _controller,
                  blastDirection: pi / 2,
                  emissionFrequency: 0.05,
                  numberOfParticles: 10,
                  maxBlastForce: 10,
                  gravity: 0.1,
                ),
              ),
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

  final _controller = ConfettiController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.safeBlockVertical * 3),
                          ),
                        ),

                        //To Do
                        //top barrier 1
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierText: spnWord1,
                          isThisBottomBarrier: false,
                        ),
                        //bottom barrier 1
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierText: spnWord2,
                          isThisBottomBarrier: true,
                        ),
                        //top barrier 2
                        MyBarrier(
                          barrierX: barrierX[1],
                          barrierText: spnWord1,
                          isThisBottomBarrier: false,
                        ),
                        //bottom barrier 2
                        MyBarrier(
                          barrierX: barrierX[1],
                          barrierText: spnWord2,
                          isThisBottomBarrier: true,
                        ),
                      ],
                    ),
                  ),
                )),
            Container(
              height: SizeConfig.safeBlockVertical * 1,
              color: Colors.green,
            ),
            SizedBox(
                height: SizeConfig.safeBlockVertical * 14,
                child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('English Word',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.safeBlockVertical * 3)),
                          SizedBox(height: SizeConfig.safeBlockVertical * 3),
                          Text(engWord,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.safeBlockVertical * 3)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('SCORE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.safeBlockVertical * 3)),
                          SizedBox(height: SizeConfig.safeBlockVertical * 3),
                          Text('${score}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.safeBlockVertical * 3)),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
