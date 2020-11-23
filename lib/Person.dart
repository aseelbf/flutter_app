import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' ;
import 'dart:async';
import 'MyMap.dart';
import 'Profile.dart';

void main() {
  runApp(Person());
}

class Person extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {
  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        Navigator.pushNamed(context,'/Settings');
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[400],
          title: Text('Your Profile'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],


        ),



        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.teal[400]],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.5, 0.9],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                    /*  CircleAvatar(
                        backgroundColor: Colors.teal[400],
                        minRadius: 35.0,
                        child: Icon(
                          Icons.call,
                          size: 50.0,
                        ),
                      ),*/
                      CircleAvatar(

                        minRadius: 60.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[50],
                          radius: 70.0,
                          backgroundImage:

                          NetworkImage('https://i.imgur.com/1J0ouZk.png'),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: 'True', style: TextStyle(fontFamily: "Pacifico-Regular", fontSize: 30)),
                        TextSpan(text: 'driver', style: TextStyle(fontFamily:"Serif",fontWeight: FontWeight.bold ,fontSize: 30)),

                      ],
                    ),
                  ),


                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[

                  Expanded(
                    child: Container(
                      color: Colors.teal[200],
                      child: ListTile(
                        title: Text(
                          'Welcome ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'You can see your information ! ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      'This will take from database',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Car Number',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      'This will take from database',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Phone Number',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'This will take from database',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

      );

  }
}