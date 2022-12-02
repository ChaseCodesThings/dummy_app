import 'package:flutter/material.dart';

class Vocab extends StatefulWidget {
  @override
  _VocabState createState() => _VocabState();
}
class _VocabState extends State<Vocab>{
  List<String> vocab = ['dog', 'cat', 'water', 'fire'];
  int position = 0;
  List<String> picture = ['assets/dog.png', 'assets/cat.png', 'assets/water.png', 'assets/fire.png'];
  @override
  Widget build(BuildContext context) {
    String current = vocab[position];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vocabulary"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Next Word",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    position++;
                    position %= (vocab.length);
                    current = vocab[position];
                  });
                },
                //child: Image.asset('assets/dog5.jpg')
              ),
              Container(
                child: Text(current,
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
              ),
              Container(
                  height: 100.0,
                  width: 150.0,
                  child: Image.asset(picture[position])
              ),
              ElevatedButton(
                child: Text("En Espanol?",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                onPressed: () {
                  Text("Perro",
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  );
                },
                //child: Image.asset('assets/dog5.jpg')
              ),

            ],
          ),
        ),
      ),
    );
  }
}