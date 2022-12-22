import 'package:flutter/material.dart';
import 'dart:async';

class FlappyBird extends StatefulWidget {

  @override
  State<FlappyBird> createState() => _FlappyBirdState();
}

enum direction{UP}

class _FlappyBirdState extends State<FlappyBird> {

  double birdY = 0;


  void jump(){
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        birdY -= 0.05;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: jump,
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
                        Container(
                          alignment: Alignment(0, birdY),
                          child: Container(
                            width: 50,
                            height: 50,
                            //child: Image.asset(assets/flappybird.png),
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

