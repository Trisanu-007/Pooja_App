import 'package:durga_pooja/login_register/register.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class SwitchScreens extends StatefulWidget {
  @override
  _SwitchScreensState createState() => _SwitchScreensState();
}

class _SwitchScreensState extends State<SwitchScreens> {
  bool signIn = true;
  void changeScreen(){
    setState(() {
      signIn = !signIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(signIn){
      return LoginPage(changeScreen: changeScreen);
    }else{
      return RegisterPage(changeScreen: changeScreen);
    }
  }
}
