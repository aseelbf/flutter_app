import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

//import 'languages_screen.dart';






class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;

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
              SettingsTile(title: 'Personal',subtitle: 'change information', onTap:(){}, leading: Icon(Icons.person)
              ),
              SettingsTile(title: 'password',subtitle: 'change password',onTap:(){}, leading: Icon(Icons.lock)),

              SettingsTile(title: 'Sign out',onTap:(){}, leading: Icon(Icons.exit_to_app)),
            ],
          ),




          //  ),
        ],
      ),
    );
  }
}