import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'SignUP.dart';
import 'Person.dart';
import 'dart:async';
import 'package:http/io_client.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    home: SignIN(),
  ));
}
//======================= main class ==================
class SignIN extends StatefulWidget {
  SignIN ({Key key}) : super(key: key);
  @override
  Sign_InClass createState() => Sign_InClass();
}

class Sign_InClass extends State<SignIN> {

  Future navigateToSubPage(context) async
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return signUP();
    }
    ));
  }

  TextEditingController usern = TextEditingController();
  TextEditingController passw = TextEditingController();
  TextEditingController carn = TextEditingController();
  TextEditingController mobilen = TextEditingController();

  Future login () async
  {
    var url = "https://192.168.2.76/flutter_app/login.php";
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, localhost, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.post(Uri.parse(url), body:{

      "username": usern.text,
      "password": passw.text,
      "mobilenumber":mobilen.text,
      "carnumber":carn.text,
    });


    var data =json.decode(response.body);

    if (data == "Success")
    {




      print("login success");


      Fluttertoast.showToast(msg: "Login is successful !",
          toastLength:Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Person()));
    }
    else
    {
      Fluttertoast.showToast(msg: "Username or Password is wrong!",
          toastLength:Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }

  }


//  _formKey and _autoValidate
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _name;
  String _Pass;

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.teal,
          title: new RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'True', style: TextStyle(fontFamily: "Pacifico-Regular", fontSize: 28)),
                TextSpan(text: 'driver', style: TextStyle(fontFamily:"Serif",fontWeight: FontWeight.bold ,fontSize: 26)),

              ],
            ),
          ),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(

              key: _formKey,
              autovalidate: _autoValidate,
              child: FormUI(),
            ),
          ),
        ),
      ),
    );
  }

// Here is our Form UI
  Widget FormUI() {
    return new Column(
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(55),
            child: Text(
              'Welcome',
              style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            )),
        //======================================================================
        new TextFormField(
        controller: usern,
          decoration: const InputDecoration( icon: Icon(Icons.person),
              //hintText: 'What do people call you?',
              labelText: 'Name *'),

          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (String val) {
            _name = val;
          },
        ),
        //======================================================================
        new TextFormField(
          controller: passw,
          decoration: const InputDecoration( icon: Icon(Icons.vpn_key),
              //hintStyle: TextStyle(height:7, fontWeight: FontWeight.bold),
              // hintText: 'please write a good password?',
              labelText: 'password *' ),
          keyboardType: TextInputType.visiblePassword,
          validator: validatePassword,
          onSaved: (String val) {
            _Pass = val;
          },
        ),
        Container(
            child: Row(
              children: <Widget>[
                Text('Does not have an account?'),
                FlatButton(
                  textColor: Colors.teal,

                  child: Text(
                    'Sign up',
                  ),
                  onPressed: () {

                    navigateToSubPage(context);
                  },


                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )),
        //======================================================================
        new SizedBox(
          height: 10.0,
        ),
        new RaisedButton(
          onPressed:()
          {
            _validateInputs();

          },
          color: Colors.teal,
          textColor: Colors.white,
          child: new Text('Login'),

        )
      ],
    );
  }
  //======================================================================
  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 characters';
    else
      return null;
  }
  //======================================================================
  String validatePassword(String value) {
    if (value.length < 8)
      return 'Password must be more than 7 characters';
    else
      return null;
  }
  //======================================================================
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      // If all data are correct then save data to out variables
      login();
      _formKey.currentState.save();
    } else {
      // If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
}




















//==============================================================================

//============================================================================== Sign up class :)
