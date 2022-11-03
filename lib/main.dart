import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'mytranslator.dart';

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
                  style: TextStyle(fontSize: 35),

                )
              ),
              Container(
                color: Colors.white,
                child: Translate()
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          onItemSelected: (index){
            setState(() {
              pageController.jumpToPage(index);
            });
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(icon: Icon(Icons.home), title: Text("Home")),
            BottomNavyBarItem(icon: Icon(Icons.language), title: Text("Translation")),
          ],
        ),
      ),
    );
  }
}