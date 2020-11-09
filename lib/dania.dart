import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: SubPage(),
  ));
}

//======================= main class ==================
class SubPage extends StatefulWidget {
  @override
  Toto createState() => Toto();
}

class Toto extends State<SubPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.teal, title: Text('Home')),
        body: Container(

            padding: EdgeInsets.all(15),
            child: ListView(
              children: <Widget>[

                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    //controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Car Number To Search',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.teal,
                      child: Text('Search'),
                      onPressed: () {
                        print(nameController.text);
                      },
                    )),
              ],
            )));
  }
}