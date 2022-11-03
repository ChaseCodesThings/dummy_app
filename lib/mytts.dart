import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
class Text2Speech {
  FlutterTts flutterTts = FlutterTts();
  void sayit(String text)
  {
    flutterTts.setLanguage("es");
    flutterTts.setSpeechRate(0.4);
    flutterTts.setPitch(1.0);
    flutterTts.speak(text);
  }
}