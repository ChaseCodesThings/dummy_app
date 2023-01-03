//add account, select account, delete account, set default account

import 'package:flutter/material.dart';
import 'database_helper.dart';
class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}
class _DataState extends State<Data>{
  final val = TextEditingController();
  final val2 = TextEditingController();
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(title: Text("Sqflite Database"),),
    body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter a Column Name"
              ),
                controller: val
            ),
            TextField(
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter an Column ID"
                ),
                controller: val2
            ),

            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () async{
                int i = await DatabaseHelper.instance.insert({
                  DatabaseHelper.columnName : val.text, DatabaseHelper.columnId : int.parse(val2.text)
                });
                print("the inserted id is $i");
              },
              child: Text("insert"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () async{
                List<Map<String,dynamic>> queryRows = await DatabaseHelper.instance.queryAll();
                print(queryRows);
              },
              child: Text("query"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () async{
                int updateId = await DatabaseHelper.instance.update({
                  DatabaseHelper.columnName : val.text, DatabaseHelper.columnId : int.parse(val2.text)
                });
                print(updateId);
              },
              child: Text("update"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
              ),
              onPressed: () async{
                int rowsEffected = await DatabaseHelper.instance.delete(int.parse(val2.text));
                print(rowsEffected);
              },
              child: Text("delete"),
            ),
          ],
        ),
      ),
    );
  }
}