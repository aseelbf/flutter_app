import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditEmail extends StatefulWidget {
  @override
  _EditEmailState createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  String username;
  String ID;
  String SignedIn;
  TextEditingController EmailController = TextEditingController();

  Future getInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {

      username = preferences.getString('username');
      ID=preferences.getString('ID');
      SignedIn=preferences.getString('SignedIn');

    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getInfo();
    });

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
                  child: username == null
                      ? null
                      : Text(username,
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Enter your new Email:',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
                TextField(
                  controller: EmailController,
                  decoration: InputDecoration(
                      labelText: 'Ex:abc@company.com',
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
                              "https://10.0.2.2/flutter_app/EditEmail.php";
                          final ioc = new HttpClient();
                          ioc.badCertificateCallback =
                              (X509Certificate cert, localhost, int port) =>
                                  true;
                          final http = new IOClient(ioc);
                          http.post(Uri.parse(url), body: {
                            'ID': ID,
                            'username': EmailController.text,
                          });
                          //*******************
                          print("I am email from controller "+ EmailController.text);
                          Fluttertoast.showToast(
                              msg: " Email changed successfully !",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                              print("I am flag in edit Email page after editing "+SignedIn);
                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          SignedIn="T";
                          preferences.setString('SignedIn', SignedIn);
                          Navigator.pushNamed(context, '/Person');
                        },
                        child: Center(
                            child: Text(
                          'Update Email',
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
