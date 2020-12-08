import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ticket extends StatefulWidget {
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  String SignedIn, ID, username;
  bool TicketFlag = false;
  String Title = "", TicketId, TicketType , Description="Description: ";
  String ticketDate;

  Future getInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {

    SignedIn = preferences.getString('SignedIn');
    ID = preferences.getString('ID');
    username = preferences.getString('username');
    TicketFlag = preferences.getBool('TicketFlag');
    Title = preferences.getString('Title');
    });
  }


String LicenseDate;
  List TrafficList = List();
  getAllTraffic() async {
    var url = "https://192.168.10.31/flutter_app/AllTraffic.php";
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
                TicketId=TrafficList[i]['ticketId'];
                ticketDate=TrafficList[i]['ticketDate'].toString();
                //LicenseDate=TrafficList[i]['LicenseDate'].toString();
            break;
          } else
            {
            TicketId = " ";
            ticketDate = " ";
          }
        }
      });

    }

    return TrafficList;

  }


  List TicketsList = List();
Future getTicketType() async
{
  var url = "https://192.168.10.31/flutter_app/AllTickets.php";
  final ioc = new HttpClient();
  ioc.badCertificateCallback =
      (X509Certificate cert, localhost, int port) => true;
  final http = new IOClient(ioc);
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    setState(() {
      TicketsList = json.decode(response.body);
      for (int i = 0; i < TicketsList.length; i++) {
        if (TicketsList[i]['ID'] == TicketId) {
          TicketType=TicketsList[i]['Description'];
          Description="Description: ";
          // ID = TrafficList[i]['ID'];

          break;
        } else
          {
          TicketType = " ";
          Description = " ";
        }
      }
    });

  }

  return TicketsList;
}



  @override
  void initState() {
    super.initState();
    getInfo();
    getAllTraffic();
    getTicketType();
    setState(() {
      print("I am ticket flag in ticket page and i am " + TicketFlag.toString());
    });

  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
            resizeToAvoidBottomPadding: true,
            appBar: AppBar(
              title: Text("Tickets"),
              leading: new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/home');
                  }),
              backgroundColor: Colors.teal[400],
            ),
            body: Card(

              child: Column(

                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Title=="You have no Tickets"? new Icon(Icons.check) :  new Icon(Icons.warning),
                    title: Title==null?null: Text(Title,style: TextStyle(color: Title=="You have no Tickets"?Colors.black:Colors.red),),
                    subtitle: TicketType ==null?null: Text(
                      (Description==null?null:Description) + (TicketType==null? null:TicketType)+"\n  "+( Title=="You have no Tickets"?" ":"on:"+ ticketDate) , style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  //Text(TicketType==null?null:TicketType),

                ],
              ),
            ),
        ));
  }
}
