import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'mytranslator.dart';
class Vocab extends StatefulWidget {
  @override
  _VocabState createState() => _VocabState();
}
class _VocabState extends State<Vocab>{
  List<String> vocab = ['Dog', 'Cat', 'Water', 'Fire'];
  int position = 0;
  List<String> picture = ['assets/dog.png', 'assets/cat.png', 'assets/water.png', 'assets/fire.png'];
  GoogleTranslator translator = GoogleTranslator();
  @override
  Widget build(BuildContext context) {
    String current = vocab[position];
    //var translation = '';
    String out = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vocabulary"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

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
                child: Text("Translate to Spanish",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                onPressed: () {
                    //translation = current;
                    translator.translate(current, to: "es").then((translation) {
                      //out = translation.toString();
                      setState(() {
                        out = translation.toString();
                      });
                      print(out);
                    });

                }
              ),
              Text(out,
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
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
              ),
              ElevatedButton(
                child: Text("Previous Word",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    position--;
                    position %= (vocab.length);
                    current = vocab[position];
                  });
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