import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:http/io_client.dart';
import 'Person.dart';



class signUP extends StatefulWidget{
  @override
  _signUPState createState() => _signUPState();
}

class _signUPState extends State<signUP>

{


//  _formKey and _autoValidate
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _name;
  String _car;
  String _mobile;
  String _Pass;


  TextEditingController usern = TextEditingController();
  TextEditingController passw = TextEditingController();
  TextEditingController carn = TextEditingController();
  TextEditingController mobilen = TextEditingController();

  Future register()  async
  {
    print("hi");
    //var url = "https://10.0.2.1//flutter_app/GP_database.php";
    var url = "https://192.168.2.76/flutter_app/GP_database.php";
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, localhost, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.post(Uri.parse(url), body: {

      "username": usern.text,
      "password": passw.text,
      "mobilenumber":mobilen.text,
      "carnumber":carn.text,

    });
    print(response);
    var data=json.decode(response.body);
    if(data=="Error"){
      Fluttertoast.showToast(
          msg: "username or car number is already exist!",
          toastLength:Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
    else if (data == "success"){
      Fluttertoast.showToast(msg:"Registration success",toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb:1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Person()));
    }
  }




  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.teal[400],
          title: new Text('Sign Up'),
        ),

        body:
        //======================================================================
        new SingleChildScrollView(
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
              'Join Us',
              style: TextStyle(

                  color: Colors.teal[400],
                  fontWeight: FontWeight.w500,
                  fontSize: 40
              ),
            )),
        //======================================================================
        new TextFormField(
          controller: usern,
          /*style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.w500,
              fontSize: 30),*/

          decoration: const InputDecoration( icon: Icon(Icons.person),
              //hintStyle: TextStyle(height:7, fontWeight: FontWeight.bold),
              hintText: 'What do people call you?',
              labelText: 'Name *'),

          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (String val) {
            _name = val;
          },
        ),
        //======================================================================
        new TextFormField(
          controller: mobilen,
          decoration: const InputDecoration( icon: Icon(Icons.phone_android),
              //hintStyle: TextStyle(height:7, fontWeight: FontWeight.bold),
              hintText: 'What us your phone number?',
              labelText: 'Mobile number *'),
          keyboardType: TextInputType.phone,
          validator: validateMobile,
          onSaved: (String val) {
            _mobile = val;
          },
        ),
        //======================================================================
        new TextFormField(
          controller: carn,
          decoration: const InputDecoration( icon: Icon(Icons.directions_car),
              //hintStyle: TextStyle(height:7, fontWeight: FontWeight.bold),
              hintText: 'What is your car number?',
              labelText: 'car number *'),
          validator:  validateCar,
          onSaved: (String val) {
            _car = val;
          },
        ),
        //======================================================================
        new TextFormField(
          controller: passw,
          decoration: const InputDecoration( icon: Icon(Icons.lock),
              //hintStyle: TextStyle(height:7, fontWeight: FontWeight.bold),
              hintText: 'please write a good password?',
              labelText: 'password' ),
          keyboardType: TextInputType.phone,
          validator: validatePassword,
          onSaved: (String val) {
            _Pass = val;
          },
        ),
        //======================================================================
        new SizedBox(
          height: 10.0,
        ),
        new RaisedButton(
          onPressed: ()
          {
            _validateInputs();
            //register();
            } ,
          color: Colors.teal,
          textColor: Colors.white,
          child: new Text('Register'),
          //  onPressed : (){register();},
        )
      ],
    );
  }
  //======================================================================
  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }
  //======================================================================
  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }
  //======================================================================
  String validateCar(String value) {
    if (value.length >11)
      return 'Car Number must be less than 11 charaters';
    else
      return null;
  }
  //======================================================================
  String validatePassword(String value) {
    if (value.length < 8)
      return 'Password must be more than 7 charaters';
    else
      return null;
  }
  //======================================================================
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      register();
      _formKey.currentState.save();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
}



