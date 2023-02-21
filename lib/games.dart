import 'package:flutter/material.dart';
import 'package:dummy_app/pong.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'flappybird.dart';

class Games extends StatefulWidget {
  @override
  State<Games> createState() => _GamesState();
}
class _GamesState extends State<Games> {
  int currentIndex = 0;
  late PageController pageController;
  @override
  void initState(){
    super.initState();
    pageController = PageController();
  }
  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: PageView(
            //physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (index){
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              Container(
                  color: Colors.white,
                  child: FlappyBird()
              ),
              Container(
                  color: Colors.white,
                  child: Pong()
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          containerHeight: MediaQuery.of(context).size.height/15.7,
          onItemSelected: (index){
            setState(() {
              pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOutCirc);
            });
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(icon: Icon(Icons.garage_outlined), title: Text("Flappy Bird")),
            BottomNavyBarItem(icon: Icon(Icons.gamepad_outlined), title: Text("Pong")),

          ],
        ),
      );
  }
}