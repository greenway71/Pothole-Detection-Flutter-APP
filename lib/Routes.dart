import 'package:flutter/material.dart';
import 'package:new_project/Developers.dart';
import 'package:new_project/Directory/connection.dart';

import 'package:new_project/Directory/signin.dart';
import 'package:new_project/Directory/signup.dart';
import 'package:new_project/Directory/welcome.dart';
import 'package:new_project/Pages/maplocation.dart';
import 'package:new_project/RouteConst.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case HomeScr:
      return MaterialPageRoute(builder: (context)=>Welcome());

    case SignUpScr:
      return MaterialPageRoute(builder:  (context)=>SignupPage());


    case SignInScr:
      return MaterialPageRoute(builder:  (context)=>LoginPage());

    case SampleScr:
      return MaterialPageRoute(builder:  (context)=>CameraHome());

    case MapScr:
      return MaterialPageRoute(builder:  (context)=>MyMap());

    case DevScr:
      return MaterialPageRoute(builder:  (context)=>DeveloperInfo());

    default:
      return MaterialPageRoute(builder: (context)=>Welcome());
  }
}