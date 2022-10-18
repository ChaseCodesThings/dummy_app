import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

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
              //SizedBox(height: 125, width: 70,
             // ),
              Text(out,
                style: TextStyle(
                  fontSize: 45,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}