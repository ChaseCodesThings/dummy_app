import 'package:flutter/material.dart';
import 'package:dummy_app/SizeConfig.dart';

class CoverScreen extends StatelessWidget {
  final bool gameStarted;
  CoverScreen({required this.gameStarted});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0.0, -0.2),
      child: Text(gameStarted ? '': 'T A P   T O   P L A Y',
        style: TextStyle(color: Colors.white, fontSize: SizeConfig.safeBlockHorizontal * 8)),
    );
  }
}
