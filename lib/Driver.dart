import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert' ;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';



class Driver extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _DriverState createState() => _DriverState();
}

class _DriverState extends State<Driver> {

  String username="";
  String car="";
  String phone="";
  String SignedIn="";
  String ID="";
  String FullName="";

  Future getInfo() async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();

    setState(()
    {
      car= preferences.getString('car');
      SignedIn= preferences.getString('SignedIn');
      ID=preferences.getString('ID');
      print(car + "In getInfo function");
    });
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
          if (usersList[i]['carnumber']==car)
          {
            username=usersList[i]['username'];
            phone=usersList[i]['mobilenumber'];
            ID=usersList[i]['ID'];
            break;

          }

        }

      });
      SharedPreferences preferences=await SharedPreferences.getInstance();
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
    getAllTraffic();

  }





  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async =>false,
        child: new Scaffold(
          appBar: AppBar(
            leading: new IconButton(icon: new Icon(Icons.arrow_back),
                onPressed:() { Navigator.of(context).pushNamed('/home');}),
            backgroundColor: Colors.teal[400],

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
                        CircleAvatar(
                        backgroundColor: Colors.teal[400],
                        minRadius: 35.0,
                        child: IconButton(
                          icon: Icon(Icons.call),
                          color: Colors.white,
                          iconSize: 50,
                          onPressed: ()
                          {
                            launch("tel://"+phone);
                          },
                        ),
                      ),
                        /*IconButton(
                          icon: Icon(Icons.call),
                          color: Colors.teal[400],
                          onPressed: () {},
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
                            'You can see ' + FullName.toUpperCase()+" information below",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
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

                      subtitle:  Text(FullName ,

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