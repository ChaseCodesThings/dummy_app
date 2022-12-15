import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  final bool gameStarted;
  final enemyScore;
  final playerScore;
  ScoreScreen({required this.gameStarted, this.enemyScore, this.playerScore});
  @override
  Widget build(BuildContext context) {
    return gameStarted ? Stack(
      children: [
        Container(
          alignment: Alignment(0,0),
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width / 3,
            color: Colors.grey,
          ),
        ),
        //enemy score
        Container(
          alignment: Alignment(0, -0.5),
          child: Container(
            child: Text(enemyScore.toString(), style: TextStyle(fontSize: 80, color: Colors.grey),),
          ),
        ),
        //player score
        Container(
          alignment: Alignment(0, 0.5),
          child: Container(
            child: Text(playerScore.toString(), style: TextStyle(fontSize: 80, color: Colors.grey),),
          ),
        ),
      ],
    ) : Container();
  }
}
