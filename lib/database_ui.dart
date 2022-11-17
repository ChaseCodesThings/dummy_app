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
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () async{
                int i = await DatabaseHelper.instance.insert({
                  DatabaseHelper.columnName : 'Chase'
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
                  DatabaseHelper.columnId: 12,
                  DatabaseHelper.columnName: "Mark"
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
                int rowsEffected = await DatabaseHelper.instance.delete(14);
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