import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'mytts.dart';
class Translate extends StatefulWidget {
  @override
  _TranslateState createState() => _TranslateState();
}
class _TranslateState extends State<Translate>{
  GoogleTranslator translator = GoogleTranslator();
  Text2Speech tts = Text2Speech();
  final language = TextEditingController();
  String out = "";
  void translate()
  {
    translator.translate(language.text, to: "es").then((output) {
      setState(() {
        out = output.toString();
      });
      print(out);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language Translation"),
      ),
      body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 125, width: 70,),
                TextField(
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  controller: language,
                ),
                ElevatedButton(
                  onPressed: () {
                    translate();
                  },
                  child: Text("Translate to Spanish",
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    tts.sayit(out);
                  },
                  child: Text("Say in Spanish",
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                ),
                Text(out,
                  style: TextStyle(
                    fontSize: 38,
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}