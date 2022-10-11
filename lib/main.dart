import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  bool pressOn = true;
  bool pressOff = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Changeable Red Button"),),
        body: Column(
          children: [
            Container(
              height: 0.0,
              width: 100.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: pressOn ? Colors.red : Colors.blue,
                    fixedSize: const Size(250, 50),
                    textStyle: const TextStyle(
                      fontSize: 25,
                    )
                ),
                child: pressOn ? Text("Make me blue!") : Text("Make me red!"),
                onPressed: (){
                  setState(() {
                    pressOn = !pressOn;
                    pressOff = !pressOff;
                  });
                },
              ),
            ),
            Container(
              height: 100.0,
              width: 100.0,
              child: Image(
                image: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fillustrations%2Fspanish-flags-cartoon&psig=AOvVaw1Hu621_ozgkM2RMQWy_ZUA&ust=1665579647751000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCOj1s-yd2PoCFQAAAAAdAAAAABAz'),
              ),
            ),
          ],
        ));
  }
}
