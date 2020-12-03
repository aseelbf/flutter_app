import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'languages_screen.dart';






class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
  String username;
  String mobile;
  String car;
  String password;


  Future getInfo() async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
     username=preferences.getString('username');
     mobile= preferences.getString('mobilenumber');
     car=preferences.getString('carnumber');
     password=preferences.getString('password');
    if(password.isEmpty)
      print ("the password is empty");
      print("I get your info "+username +', '+ mobile +', '+ car+' ,'+ password);

  }

  Future Logout () async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.pushNamed(context,'/home');
  }


  @override
  void initState()
  {
    super.initState();
    getInfo();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings '),
          backgroundColor: Colors.teal),
      body: SettingsList(
        // backgroundColor: Colors.orange,
        sections: [
          //  SettingsSection(
          //    title: 'Common',
          // titleTextStyle: TextStyle(fontSize: 30),
          //    tiles: [
          //      SettingsTile(
          //      title: 'Language',
          //     subtitle: 'English',
          //     leading: Icon(Icons.language),
          //     onTap: () {
          //      Navigator.of(context).push(MaterialPageRoute(
          //      ));
          //    },
          //    ),
          //    SettingsTile(
          //      title: 'Environment',
          //      subtitle: 'Production',
          //      leading: Icon(Icons.cloud_queue),
          //      onTap: () => print('e'),
          //    ),
          //   ],
          //  ),
          SettingsSection(
            title: 'Account Setting' ,
            titleTextStyle: TextStyle(fontSize: 30 ),
            tiles: [
              SettingsTile(title: 'Personal information',subtitle: 'change information',
                  onTap:() async
                  {

                  }, leading: Icon(Icons.person)
              ),
              SettingsTile(title: 'password',subtitle: 'change password',
                  onTap:() async
              {
                SharedPreferences preferences=await SharedPreferences.getInstance();
                preferences.setString('mobilenumber', mobile);
                preferences.setString('carnumber', car);
                preferences.setString('password', password);
                preferences.setString('username', username);
                Navigator.pushNamed(context,'/Change');
              },
                  leading: Icon(Icons.lock)),

              SettingsTile(title: 'Sign out',
                  onTap:() async
                  {
                   Logout();
                  }, leading: Icon(Icons.exit_to_app)),
            ],
          ),




          //  ),
        ],
      ),
    );
  }
}