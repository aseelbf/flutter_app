import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class License extends StatefulWidget {
  @override
  _LicenseState createState() => _LicenseState();
}

class _LicenseState extends State<License> {
 String ID,SignedIn,username="abc";
 DateTime LicenseDate;
 DateTime Ldate;
 int DifInDays;
 String isValid;
 Future getInfo()async
 {
   SharedPreferences preferences= await SharedPreferences.getInstance();
   SignedIn= preferences.getString('SignedIn');
   ID=preferences.getString('ID');
   username=preferences.getString('username');

 }

 String LicenseDateString=" ";
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
           LicenseDateString=TrafficList[i]['LicenseDate'].toString();
           //**************
           List date=LicenseDateString.split("-");
           int Year=int.parse(date[0]);
           int Month=int.parse(date[1]);
           int day=int.parse(date[2]);
           Ldate = new DateTime(Year,Month,day);
           final date2 = DateTime.now();
           final difference = date2.difference(Ldate).inDays;
           DifInDays=difference;
           print(DifInDays);
           if (DifInDays>730)
             isValid="NO";
           else
             isValid="Yes";
           break;
         } else
         {
           SignedIn="F";
         }
       }
     });

   }


   return TrafficList;



 }



 @override
  void initState() {

    super.initState();
    setState(() {
      getInfo().then((value) => null);
      getAllTraffic();
      
    });


     // LicenseDate=FormatDate(LicenseDateString);



  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
          resizeToAvoidBottomPadding: true,
          appBar: AppBar(
            title: Text("License Status"),
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
                  leading: isValid=="Yes"? new Icon(Icons.check) :  new Icon(Icons.warning),
                  title: isValid=="Yes"?Text("Your License is Valid"): Text("Your License is expired"),// Title==null?null: Text(Title,style: TextStyle(color: Title=="You have no Tickets"?Colors.black:Colors.red),),
                  subtitle: isValid=="Yes"?Text(" "): Text("it's expired "+ DifInDays.toString() +" Days ago"),
                ),
                //Text(TicketType==null?null:TicketType),

              ],
            ),
          ),
        ));
  }
}

