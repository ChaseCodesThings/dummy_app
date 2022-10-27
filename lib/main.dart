import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
));
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  GoogleTranslator translator = GoogleTranslator();
  FlutterTts flutterTts = FlutterTts();
  String out = "";
  final language = TextEditingController();
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
        title: const Text("Language Translation Prototype"),
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
                  flutterTts.setLanguage("es");
                  flutterTts.setSpeechRate(0.4);
                  flutterTts.setPitch(1.0);
                  flutterTts.speak(out);
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