import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/SignIn.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIN()));
  }

  TextEditingController CurrentPasswordController = TextEditingController();
  TextEditingController NewpasswordController = TextEditingController();
  TextEditingController ConfirmpasswordController = TextEditingController();
  String username;
  String password;
  String SignedIn;
  List usersList = List();
  String TruePassword;
  bool PassCorrect;

  Future getInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString('username');
    password = preferences.getString('password');
    print("I get your info " + username + ' ,' + password);
  }

  getAllUsers() async {
    var url = "https://10.0.2.2/flutter_app/Allusers.php";
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, localhost, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      if (this.mounted)
      setState(() {
        usersList = json.decode(response.body);
        for (int i = 0; i < usersList.length; i++) {
          if (usersList[i]['username'] == username) {
            SignedIn = "T";
            TruePassword = usersList[i]['password'];
            print("Hi " +
                usersList[i]['username'] +
                ", Your flag is " +
                SignedIn);
            break;
          } else
            SignedIn = "F";
        }
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('SignedIn', SignedIn);
    }
    print(usersList);
    return usersList;
  }

  @override
  void initState() {
    super.initState();
    getInfo();
    getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.teal[400],
            title: Text('Reset your password')),
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
                    controller: CurrentPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Current password',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    controller: NewpasswordController,
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
                    controller: ConfirmpasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm New Password',
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
                      onPressed: () async {
                        if (TruePassword == CurrentPasswordController.text &&
                            NewpasswordController.text ==
                                ConfirmpasswordController.text)
                        {
                          var url =
                              "https://10.0.2.2/flutter_app/ResetPassword.php";
                          final ioc = new HttpClient();
                          ioc.badCertificateCallback =
                              (X509Certificate cert, localhost, int port) =>
                                  true;
                          final http = new IOClient(ioc);
                             http.post(Uri.parse(url), body: {
                            'username': username,
                            'password': NewpasswordController.text,
                          });

                          Fluttertoast.showToast(msg: "Password changed successfully !",
                              toastLength:Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          Navigator.pushNamed(context,'/home');
                        }
                        else
                          {
                          print("There is something wrong in change password function");
                        }
                      },
                    )),
              ],
            )));
  }
}
