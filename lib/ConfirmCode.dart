
import 'package:flutter/material.dart';

class ConfirmCode extends StatefulWidget {

  @override
  _Confirm createState() => _Confirm();
}

class _Confirm extends State<ConfirmCode> {


  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
        home: new Scaffold(

        appBar: AppBar(backgroundColor: Colors.teal[400], title: Text('Code receive')),
        // drawerScrimColor: Colors.pink,
        body: Container(
            constraints: BoxConstraints.expand(),

            padding: EdgeInsets.all(15),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(55),
                    child: Text(
                      'Write code here',
                      style: TextStyle(
                          color: Colors.teal[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    //  obscureText: true,
                    //controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'code',
                    ),
                  ),
                ),

                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.teal[400],
                      child: Text('validate'),
                      onPressed: () {
                        print(nameController.text);
                        print(passwordController.text);
                      },
                    )),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('Didnt receive code ?'),
                        FlatButton(
                          textColor: Colors.teal[400],
                          child: Text(
                            'click here',
                          ),
                          onPressed: () {

                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            ))));
  }
}


