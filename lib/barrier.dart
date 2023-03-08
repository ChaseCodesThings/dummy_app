import 'package:dummy_app/SizeConfig.dart';
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
    SizeConfig().init(context);
    return Container(
      alignment: Alignment(barrierX, isThisBottomBarrier ? 1 : -1),
      child: Container(
        color: isThisBottomBarrier
            ? Colors.red.withOpacity(0.5)
            : Colors.blue.withOpacity(0.5),
        width: SizeConfig.safeBlockHorizontal * 27,
        height: SizeConfig.safeBlockVertical * 32.245,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            barrierText,
            style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.safeBlockVertical * 4),
          ),
        ),
      ),
    );
  }
}
