// change show all accounts to drop down menu

import 'package:flutter/material.dart';
import 'database_helper.dart';
class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}
class _DataState extends State<Data>{
  final val = TextEditingController();
  final val2 = TextEditingController();
  String out = '';
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
                labelText: "Enter a User Name"
              ),
                controller: val
            ),
            TextField(
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter a User Number"
                ),
                controller: val2
            ),
            Text(out,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
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
              child: Text("Add Account"),
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
              child: Text("Set Default account"),
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
              child: Text("Delete Account"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () async{
                List<Map<String,dynamic>> queryRows = await DatabaseHelper.instance.queryAll();
                out = queryRows.toString();
                print(out);
              },
              child: Text("Show all Accounts"),
            ),
            //DropdownButton(items: , onChanged: ),
          ],
        ),
      ),
    );
  }
}