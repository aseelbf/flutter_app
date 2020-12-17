import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EditInfo extends StatefulWidget {
  @override
  _EditInfoState createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  String username;
  String car;
  String mobile;
  String ID;

  Future getInfo() async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(()
    {
      username=preferences.getString('username');
      mobile = preferences.getString('mobilenumber');
      car = preferences.getString('carnumber');
      ID=preferences.getString('ID');
      print("These are your information from getInfo Function in Edit page "+mobile+" "+car);
    });
  }

  Future KeepInfo() async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString('mobilenumber', mobile);
    preferences.setString('carnumber', car);
    preferences.setString('username', username);
    preferences.setString('ID', ID);

  }

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:
            AppBar(title: Text('Settings '), backgroundColor: Colors.teal[400]),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(children: <Widget>[
            ListTile(
              leading: IconButton(

                icon: Icon(Icons.edit),
                onPressed: ()
                {
                  KeepInfo();
                  //Navigator.pushNamed(context,'/editEmail');
                }
                ,),
              title: Text("Email"),
              subtitle: username==null?null: Text(username),
            ),
            ListTile(
              leading: IconButton(

                icon: Icon(Icons.edit),
                onPressed: ()
                {
                  KeepInfo();
                  Navigator.pushNamed(context,'/EditMobile');
                }
                ,),
              title: Text("Mobile Number"),
              subtitle: mobile==null?null: Text(mobile),
            ),
            ListTile(
              leading: IconButton(
                 icon: Icon(Icons.edit),
              onPressed: ()
              {
                KeepInfo();
                Navigator.pushNamed(context,'/EditCar');

              }
              ,),

              title: Text("Car Number"),
              subtitle: car==null?null: Text(car),
            ),


          ]),
        ));
  }
}
