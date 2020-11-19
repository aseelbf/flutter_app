
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/SignIn.dart';
import 'SignIn.dart';

void main() {
  runApp(ChangePassword());
}

//======================= main class ==================
class ChangePassword extends StatefulWidget {
  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>SignIN()));
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.teal[400], title: Text('Reset your password')),
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
                      'Change password ',
                      style: TextStyle(
                          color: Colors.teal[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),

                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,

                    //controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New password',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: TextField(
                    obscureText: true,
                    // controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.teal[400],
                      child: Text('Reset'),
                      onPressed: () {
                        print(nameController.text);
                        print(passwordController.text);
                      },
                    )),

              ],
            )));
  }
}





