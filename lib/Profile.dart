import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signUP.dart';
import 'SignIn.dart';

class Profile extends StatefulWidget{
  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile> {
  String SignedIn = "Empty";
  @override
  Widget build(BuildContext context) {

    Future getFlag()async
    {
      SharedPreferences preferences= await SharedPreferences.getInstance();
      SignedIn = preferences.getString('SignedIn');
    }

    @override
    void initState() {
      super.initState();
      getFlag();

    }



    int CurrentIndex_= 2;
    // TODO: implement build
    return new WillPopScope(
        onWillPop: () async =>false,
    child: new  Scaffold(

      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          leading: new IconButton(icon: new Icon(Icons.arrow_back),
              onPressed:() { Navigator.of(context).pushNamed('/home');}),

          backgroundColor: Colors.teal[400]
      ),

      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text('Hello',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                  child: Text('There',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                  child: Text('.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[



                  Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.tealAccent,
                      color: Colors.teal[400],
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context,'/SignIn');
                        },
                        child: Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),






                ],
              )),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'New to TrueDriver ?',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {

                      Navigator.pushNamed(context,'/signUP');
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ],
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
    ));
  }
}
