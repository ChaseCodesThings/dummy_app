import 'package:flutter/material.dart';
import 'database_helper.dart';
class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}
class _DataState extends State<Data>{
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(title: Text("Sqflite Database"),),
    body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              onPressed: (){},
              child: Text("insert"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
              ),
              onPressed: (){},
              child: Text("query"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              onPressed: (){},
              child: Text("update"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
              ),
              onPressed: (){},
              child: Text("delete"),
            ),
          ],
        ),
      ),
    );
  }
}