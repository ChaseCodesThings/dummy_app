import 'package:flutter/material.dart';

class Vocab extends StatefulWidget {
  @override
  _VocabState createState() => _VocabState();
}
class _VocabState extends State<Vocab>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vocabulary"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                child: Text("Dog",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
              ),
              Container(
                  height: 100.0,
                  width: 150.0,
                  child: Image.asset('assets/dog5.jpg')
              ),
              Container(
                  height: 100.0,
                  width: 150.0,
                  child: Image.asset('assets/dog.jpg')
              ),
              Container(
                  height: 100.0,
                  width: 150.0,
                  child: Image.asset('assets/dog4.png')
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