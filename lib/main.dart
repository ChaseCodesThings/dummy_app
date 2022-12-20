import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'mytranslator.dart';
import 'package:dummy_app/vocab.dart';
import 'package:dummy_app/database_ui.dart';
import 'games.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Vernacular Prototype")),
        body: SizedBox.expand(
          child: PageView(
            controller: pageController,
            onPageChanged: (index){
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              Container(
                 padding: const EdgeInsets.all(45),
                 alignment: Alignment.center,
                  color: Colors.blue,
                child: const Text("Welcome to my App Prototype",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35),
                )
              ),
              Container(
                color: Colors.white,
                child: Vocab()
              ),
              Container(
                  color: Colors.purple,
                  child: Games()
              ),
              Container(
                  color: Colors.amber,
                  child: Translate()
              ),
              Container(
                  color: Colors.blueGrey,
                  child: Data()
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          onItemSelected: (index){
            setState(() {
              pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOutCirc);
            });
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(icon: Icon(Icons.home), title: Text("Home")),
            BottomNavyBarItem(icon: Icon(Icons.workspace_premium_outlined), title: Text("VocabUlary")),
            BottomNavyBarItem(icon: Icon(Icons.gamepad), title: Text("Games")),
            BottomNavyBarItem(icon: Icon(Icons.language), title: Text("Translation")),
            BottomNavyBarItem(icon: Icon(Icons.person_outline), title: Text("Database")),
          ],
        ),
      ),
    );
  }
}