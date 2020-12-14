import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmCode extends StatefulWidget {
  @override
  _Confirm createState() => _Confirm();
}

class _Confirm extends State<ConfirmCode> {
  String username = "";
  String mobilenumber = "";

//**********************FIREBASE SECTION**************************************************
  /*TextEditingController _smsCodeController = TextEditingController();
  //TextEditingController _phoneNumberController = TextEditingController();
  String verificationId;
String smsCode;
  ///

  Future<void> verifyphone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId)
    {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend])
    {
      this.verificationId = verId;
    };

    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user)
    {
      print('vefified');
    };

    final PhoneVerificationFailed variFailed= (FirebaseAuthException exeption)
    {
      print('${exeption.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this.mobilenumber,
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodeSent,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
    );
  }
*/
//**********************************************************************************

  Future getInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      username = preferences.getString('usernameConfirm');
      print(username + " From getInfo function ");
    });
  }

//*************** ****************************************get all users function
  List usersList = List();
  getAllUsers() async {
    var url = "https://10.0.2.2/flutter_app/Allusers.php";
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, localhost, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        usersList = json.decode(response.body);
        for (int i = 0; i < usersList.length; i++) {
          if (usersList[i]['username'] == username) {
            print("I found your username");
            mobilenumber = usersList[i]['mobilenumber'];
            print("your mobile number is " + mobilenumber);
            break;
          }
        }
      });
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

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.teal[400], title: Text('Code receive')),
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
                          "We have sent code to your number :" +
                              "xxxxxxx" +
                              mobilenumber.substring(7) +
                              ", Please enter it in the box below:",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        //  obscureText: true,
                      //  controller: _smsCodeController,
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
                          onPressed: () {},
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
                  ],
                ))));
  }
}
