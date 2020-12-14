import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCar extends StatefulWidget {
  @override
  _EditCarState createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  String username;
  String car;
  String mobile;

  TextEditingController carController = TextEditingController();

  Future getInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      mobile = preferences.getString('mobilenumber');
      car = preferences.getString('carnumber');
      username = preferences.getString('username');
      print("These are your information from getInfo Function in Edit car " +
          mobile +
          " " +
          car);
    });
  }

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        //title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 75.0, 0.0, 0.0),
                  child: car == null
                      ? null
                      : Text(car,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Enter your new car number:',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
                TextField(
                  controller: carController,
                  decoration: InputDecoration(
                      labelText: 'Ex:12345678P',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                ),
                SizedBox(height: 40.0),
                Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.teal,
                    color: Colors.teal[400],
                    elevation: 7.0,
                    child: FlatButton(
                        onPressed: () async {
                          var url =
                              "https://10.0.2.2/flutter_app/EditCar.php";
                          final ioc = new HttpClient();
                          ioc.badCertificateCallback =
                              (X509Certificate cert, localhost, int port) =>
                          true;
                          final http = new IOClient(ioc);
                          http.post(Uri.parse(url), body: {
                            'username': username,
                            'carnumber': carController.text,
                          });
                          print("I am number from controller "+ carController.text);

                          Fluttertoast.showToast(
                              msg: "Car number changed successfully !",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.pushNamed(context, '/Person');
                        },
                        child: Center(
                            child: Text(
                              'Update car number',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white),
                            ))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
