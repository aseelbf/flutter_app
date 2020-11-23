import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutterapp/ConfirmCode.dart';
import 'dart:async';
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

void main() => runApp(MaterialApp(

  home: Home(),
  routes:
  {
    '/home': (context)=> Home(),
    '/Map':(context)=> MyMap(),
    '/Profile': (context)=> Profile(),
    '/signUP' : (context)=> signUP(),
    '/SignIn' : (context)=> SignIN(),
    '/Person' : (context)=> Person(),
    '/Change': (context)=> ChangePassword(),
    '/Confirm': (context)=> ConfirmCode(),
    '/Settings':(context)=>SettingsScreen(),
  },
));



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home>
{
  int CurrentIndex_= 1;
  //****************************************************************************************************************************************************


  Future <List <Fuel>> getDataFromXML(BuildContext context) async
{
  String xmlString = await DefaultAssetBundle.of(context).loadString("assets/data/Fuel.xml");
 var raw = xml.XmlDocument.parse(xmlString);
 var elements =raw.findAllElements("Aseel");
 return elements.map((element)
 {
   return Fuel(element.findElements("countryCode").first.text,
     element.findElements("date").first.text,
     element.findElements("currency").first.text,
     double.parse(element.findElements("gasoline").first.text) );
 }).toList();
}





  //**********************************************************
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: ImageIcon(AssetImage("assets/images/search3.png") ),
          title: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'True', style: TextStyle(fontFamily: "Pacifico-Regular", fontSize: 28)),
                TextSpan(text: 'driver', style: TextStyle(fontFamily:"Serif",fontWeight: FontWeight.bold ,fontSize: 26)),

              ],
            ),
          ),
          // Text('truedriver' +"", style: TextStyle(  fontSize:23.0 ,letterSpacing: 2.0, fontFamily: 'Pacifico-Regular',), ),
          //centerTitle: true,
          backgroundColor: Colors.teal[400]
      ),
      body:

      Container(
        padding: EdgeInsets.all(10),


        child: ListView(
          children: <Widget>[

            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                //controller: nameController,
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
                    // print(nameController.text);
                  },
                )),
            SizedBox(height:22.0),
             Container(
               height: 120.0,
               child: FutureBuilder(
                 future: getDataFromXML(context),
                 builder: (context,data)
                 {
                   if (data.hasData)
                     {
                       print("THERE IS DATA IN ME");
                  List <Fuel> _fuel = data.data;
                  return ListView.builder(

                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _fuel.length,
                      itemBuilder: (context,index)


                      {

                          return Container(
                            width: 200,
                           child:Card(
                             color: Colors.yellow[100],
                           child: ListTile(

                              leading: ImageIcon(AssetImage("assets/images/gas-pump.png") , color: Colors.red,),
                              title: Text(_fuel[index].countryCode +" Price in " +
                                  _fuel[index].date,
                                  style: TextStyle(fontFamily: "Serif",fontSize: 16.5,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(_fuel[index].gasoline.toString() + " "+
                                  _fuel[index].currency,
                                  style: TextStyle(fontSize: 18.0)
                              ),


                          )));



                      }

                  );

                     }
                  else
                   {
                     print("I can't read data");
                     return Center(child: CircularProgressIndicator());
                   }
                 },
               ),
             ),
//*************************************************************************************


//***************************************************************************************



          ],
        ),




      ),





      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.easeInCirc,
        color: Colors.teal[400],
        backgroundColor: Colors.grey[300],
        animationDuration: Duration(
            milliseconds: 100
        ),
        height: 60,

        index: CurrentIndex_,
        items: <Widget> [
          IconButton(icon: Icon(Icons.location_on) , iconSize:35, focusColor: Colors.grey[300],
              onPressed:()
              {
                Navigator.pushNamed(context,'/Map');

              }),


          IconButton(icon: Icon(Icons.home), iconSize:35, focusColor: Colors.grey[300],
              onPressed:()
              {
                Navigator.pushNamed(context,'/home');

              }),

          IconButton(icon: Icon(Icons.person_outline), iconSize:35, focusColor: Colors.grey[300],
              onPressed:()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));

              }),

        ],
        onTap: (index){
          setState(()
          {
            CurrentIndex_=index;

          } );
        },

      ),
    );
  }
}

