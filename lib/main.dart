import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutterapp/ConfirmCode.dart';
import 'package:flutterapp/EditCar.dart';
import 'package:flutterapp/EditPhone.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:slide_button/slide_button.dart';
import 'Driver.dart';
import 'EditInfo.dart';
import 'MyMap.dart';
import 'Profile.dart';
import 'signUP.dart';
import 'SignIn.dart';
import 'package:xml/xml.dart' as xml;
import 'Fuel.dart';
import 'Person.dart';
import 'ChangePassword.dart';
import 'ConfirmCode.dart';
import 'Settings.dart';
import 'EditPhone.dart';
import 'EditCar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var SignedIn = preferences.getString('SignedIn');

  runApp(MaterialApp(
    home: SignedIn == null ? Home() : MyMap(),
    routes: {
      '/home': (context) => Home(),
      '/Map': (context) => MyMap(),
      '/Profile': (context) => Profile(),
      '/signUP': (context) => signUP(),
      '/SignIn': (context) => SignIN(),
      '/Person': (context) => Person(),
      '/Change': (context) => ChangePassword(),
      '/Confirm': (context) => ConfirmCode(),
      '/Settings': (context) => SettingsScreen(),
      '/edit': (context) => EditInfo(),
      '/EditMobile': (context) => EditPhone(),
      '/EditCar': (context) => EditCar(),
    },
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String SignedIn = "Empty";
  String userr;

  TextEditingController SearchController = TextEditingController();
//*********************************************************************
  Future getFlag() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      SignedIn = preferences.getString('SignedIn');

      print(
          "I'm your flag in getFlag function in the main class : " + SignedIn);
    } catch (Exception) {
      print("M3lish");
    }
  }
//******************************************************

  Future keepFlag() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('SignedIn', SignedIn);
  }

  //**********************************************
  Future Search() async {
    var url = "https://192.168.10.26/flutter_app/Search.php";

    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, localhost, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.post(Uri.parse(url), body: {
      "carnumber": SearchController.text,
    });

    var data = json.decode(response.body);

    if (data == "Success") {
      showAlertDialogExist(context);
    } else {
      showAlertDialogNotExist(context);
    }
  }

  int CurrentIndex_ = 1;
  //****************************************************************************************************************************************************
  showAlertDialogExist(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Visit Profile"),
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('car', SearchController.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Driver()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(""),
      content:
          Text("Owner found! , click Visit Profile to view more information"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

//***********************************************************************************
  showAlertDialogNotExist(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Driver not found"),
      content: Text("Make sure that you typed a valid car number"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

//*************************************************************
  Future<List<Fuel>> getDataFromXML(BuildContext context) async {
    String xmlString =
        await DefaultAssetBundle.of(context).loadString("assets/data/Fuel.xml");
    var raw = xml.XmlDocument.parse(xmlString);
    var elements = raw.findAllElements("Aseel");
    return elements.map((element) {
      return Fuel(
          element.findElements("countryCode").first.text,
          element.findElements("date").first.text,
          element.findElements("currency").first.text,
          double.parse(element.findElements("gasoline").first.text));
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    getFlag();
    keepFlag();
  }

  //**********************************************************
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: ImageIcon(AssetImage("assets/images/search3.png")),
          title: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'True',
                    style: TextStyle(
                        fontFamily: "Pacifico-Regular", fontSize: 28)),
                TextSpan(
                    text: 'driver',
                    style: TextStyle(
                        fontFamily: "Serif",
                        fontWeight: FontWeight.bold,
                        fontSize: 26)),
              ],
            ),
          ),
          // Text('truedriver' +"", style: TextStyle(  fontSize:23.0 ,letterSpacing: 2.0, fontFamily: 'Pacifico-Regular',), ),
          //centerTitle: true,
          backgroundColor: Colors.teal[400]),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: SearchController,
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
                    Search();
                  },
                )),
            SizedBox(height: 22.0),
            Container(
              height: 120.0,
              child: FutureBuilder(
                future: getDataFromXML(context),
                builder: (context, data) {
                  if (data.hasData) {
                    print("THERE IS DATA IN ME");
                    List<Fuel> _fuel = data.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _fuel.length,
                        itemBuilder: (context, index) {
                          return Container(
                              width: 200,
                              child: Card(
                                  color: Colors.yellow[100],
                                  child: ListTile(
                                    leading: ImageIcon(
                                      AssetImage("assets/images/gas-pump.png"),
                                      color: Colors.red,
                                    ),
                                    title: Text(
                                        _fuel[index].countryCode +
                                            " Price in " +
                                            _fuel[index].date,
                                        style: TextStyle(
                                            fontFamily: "Serif",
                                            fontSize: 16.5,
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Text(
                                        _fuel[index].gasoline.toString() +
                                            " " +
                                            _fuel[index].currency,
                                        style: TextStyle(fontSize: 18.0)),
                                  )));
                        });
                  } else {
                    print("I can't read data");
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),

//*************************************************************************************

            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: SlideButton(
                height: 64,
                backgroundChild: Center(
                  child: Text("Slide to right to Check ticket", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                ),
                backgroundColor: Colors.white,
                slidingBarColor: Colors.teal[400],
                slideDirection: SlideDirection.RIGHT,
                slidingChild: Icon(Icons.directions_walk),
                  shouldCloseBorders: true,
                onButtonOpened: () {
                  print("Opened");
                  Navigator.pushNamed(context, '/Person');
                },
                onButtonClosed: () {
                  print("closed");
                },
                onButtonSlide: (value) {
                  print(value.toString());
                },
              ),
            ),

//***************************************************************************************
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.easeInCirc,
        color: Colors.teal[400],
        backgroundColor: Colors.grey[300],
        animationDuration: Duration(milliseconds: 100),
        height: 60,
        index: CurrentIndex_,
        items: <Widget>[
          IconButton(
              icon: Icon(Icons.location_on),
              iconSize: 35,
              focusColor: Colors.grey[300],
              onPressed: () {
                Navigator.pushNamed(context, '/Map');
              }),
          IconButton(
              icon: Icon(Icons.home),
              iconSize: 35,
              focusColor: Colors.grey[300],
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              }),
          IconButton(
              icon: Icon(Icons.person_outline),
              iconSize: 35,
              focusColor: Colors.grey[300],
              onPressed: () {
                print(SignedIn);
                if (SignedIn == "T")
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Person()));
                else
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
              }),
        ],
        onTap: (index) {
          setState(() {
            CurrentIndex_ = index;
          });
        },
      ),
    );
  }
}
