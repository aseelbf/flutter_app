import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterapp/Profile.dart';
import 'package:flutterapp/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' ;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences=await SharedPreferences.getInstance();
  var SignedIn= preferences.getString('SignedIn');
  runApp(MaterialApp(
    home: SignedIn==null? Person() : Home(),
  ));
}

class Person extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {

  String username="";
  String car="";
  String phone="";
  String SignedIn="";
  String password="";
  String FullName="";
  String ID="";
  Future getUsername() async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();

    setState(()
    {
      FullName=preferences.getString('FullName');
      username= preferences.getString('username');
      SignedIn= preferences.getString('SignedIn');
      password=preferences.getString('password');
    });
  }


  //logout Function:
  Future Logout () async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.remove('username');
    preferences.remove('SignedIn');
    preferences.remove('password');
    Navigator.pushNamed(context,'/home');
  }




  List usersList = List();
  getAllUsers ()async
  {
    var url = "https://10.0.2.2/flutter_app/Allusers.php";
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, localhost, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(Uri.parse(url));

    if (response.statusCode==200)
      {
        setState(()
        {
          usersList=json.decode(response.body);
          for (int i=0; i< usersList.length;i++)
          {
            if (usersList[i]['username']==username)
            {
              SignedIn="T";
              print("Hi "+ usersList[i]['username'] +", Your flag is "+SignedIn);
              car=usersList[i]['carnumber'];
              phone=usersList[i]['mobilenumber'];
              ID=usersList[i]['ID'];
              break;

            }

           else
             SignedIn="F";
          }

        });
        SharedPreferences preferences=await SharedPreferences.getInstance();
        preferences.setString('SignedIn', SignedIn);
      }
    print(usersList);
    return usersList;

  }



  List TrafficList = List();
  getAllTraffic() async {
    var url = "https://10.0.2.2/flutter_app/AllTraffic.php";
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, localhost, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        TrafficList = json.decode(response.body);
        for (int i = 0; i < TrafficList.length; i++) {
          if (TrafficList[i]['ID'] == ID) {
            FullName = TrafficList[i]['FullName'];


            break;
          }
        }
      });
    }
    print(FullName);
    return TrafficList;
  }
  @override
  void initState() {

    super.initState();
    setState(()
    {
      getUsername().then((value) => null);
      getAllUsers().then((value) => null);
      getAllTraffic().then((value) => null);;
    });


  }


  void handleClick(String value) async{
    switch (value) {
      case 'Logout':
        Logout();
        break;
      case 'Settings':
        SharedPreferences preferences=await SharedPreferences.getInstance();
        preferences.setString('mobilenumber', phone);
        preferences.setString('FullName', FullName);
        preferences.setString('carnumber', car);
        preferences.setString('password', password);
        preferences.setString('username', username);
        preferences.setString('ID',ID);
        Navigator.pushNamed(context,'/Settings');
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async =>false,
        child: new Scaffold(
        appBar: AppBar(
          leading: new IconButton(icon: new Icon(Icons.arrow_back),
              onPressed:() async{

              SharedPreferences preferences=await SharedPreferences.getInstance();
              preferences.setString('FullName', FullName);
              preferences.setString('SignedIn', SignedIn);
              Navigator.of(context).pushNamed('/home');

        }),
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
                    height: 12,
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
                          'Welcome ' + FullName.toUpperCase()+"!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
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
                      'Email',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle:  Text(username ,

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
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
                      car,
                      style: TextStyle(
                        fontSize: 18,
                          fontWeight: FontWeight.bold,
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
                      phone,
                      style: TextStyle(
                        fontSize: 18,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

      ));

  }
}