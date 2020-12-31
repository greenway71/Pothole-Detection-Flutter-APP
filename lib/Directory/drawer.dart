import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_project/Developers.dart';
import 'package:new_project/Directory/connection.dart';
import 'package:new_project/Pages/maplocation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_project/main.dart';

class AppDrawer extends StatelessWidget {
  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image:  AssetImage('assets/menu.gif'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Pothole Detection System",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(icon: Icons.pin_drop, text: 'Go to potholes map',onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:  (context)=>MyMap()));}),
          _createDrawerItem(icon: Icons.image, text: 'Upload Sample',onTap: ()
          {Navigator.push( context, MaterialPageRoute(builder:  (context)=>CameraHome()));}),

          Divider(),
          _createDrawerItem(
              icon: Icons.collections_bookmark, text: 'About Developers',onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DeveloperInfo()));
          }),

        Divider(),
        _createDrawerItem(
            icon: Icons.collections_bookmark, text: 'Log out current user',onTap: () async {
              try{
                await FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
              }
              catch(err){
                print(err);
              }
        }),

          Divider(),
          _createDrawerItem(icon: Icons.exit_to_app, text: 'Close the program',
              onTap: ()
              {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }),
          ListTile(
            title: Text('Version 0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}