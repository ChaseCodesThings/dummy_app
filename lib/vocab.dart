import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
// add speaker icon to translation
class Vocab extends StatefulWidget {
  @override
  _VocabState createState() => _VocabState();
}
class _VocabState extends State<Vocab>{
  List<String> vocab = ['Dog', 'Cat', 'Water', 'Fire'];
  int position = 0;
  List<String> picture = ['assets/dog.png', 'assets/cat.png', 'assets/water.png', 'assets/fire.png'];
  GoogleTranslator translator = GoogleTranslator();
  String translation = '';
  String out = 'Translation';
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(current,
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              Container(
                  height: 200,
                  width: 350,
                  child: Image.asset(picture[position])
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                    child: Text("Translate to Spanish",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  onPressed: () {
                    translator.translate(current, to: "es").then((translation) {
                      setState(() {
                        out = translation.toString();
                      });
                    });
                  }
                ),
              ),
              Text(out,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  child: Text("Next Word",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      position++;
                      position %= (vocab.length);
                      current = vocab[position];
                      out = '';
                    });
                  },
                ),
              ),
              SizedBox(
                  height: 50,
                  width: 300,
                child: ElevatedButton(
                  child: Text("Previous Word",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      position--;
                      position %= (vocab.length);
                      current = vocab[position];
                      out = '';
                    });
                  },
                  //child: Image.asset('assets/dog5.jpg')
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}