import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final barrierX;
  final barrierText;
  //final barrierLocation;
  final bool isThisBottomBarrier;

  MyBarrier({

    this.barrierX,
    this.barrierText,
    required this.isThisBottomBarrier,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(barrierX ,isThisBottomBarrier ? 1 : -1),
      child: Container(
        color: isThisBottomBarrier ? Colors.red.withOpacity(0.5) : Colors.blue.withOpacity(0.5),
          width: MediaQuery.of(context).size.width/4,
          height: (((MediaQuery.of(context).size.height) - (MediaQuery.of(context).size.height/57.8 + MediaQuery.of(context).size.height/5.38 + MediaQuery.of(context).size.height/15.5 + MediaQuery.of(context).size.height/15.5 + MediaQuery.of(context).size.height/9.1)) / 2),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            barrierText,
            style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width/17),
          ),
        ),
      ),
    );
  }
}
