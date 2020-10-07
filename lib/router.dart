import 'package:durga_pooja/database_services/user_database.dart';
import 'package:durga_pooja/home.dart';
import 'package:durga_pooja/shared_resources/authenticate.dart';
import 'package:durga_pooja/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Authenticate authenticate = Provider.of<Authenticate>(context);
    return Scaffold(
      body: StreamBuilder(
        stream: authenticate.onAuthStateChange,
        builder: (context, snapshot){
          if(snapshot.hasData || snapshot.connectionState == ConnectionState.active){
            if(snapshot.data == null){
              return SignInPage();
            }return HomePage();
          }else if(snapshot.hasError){
            return Center(child: Text(snapshot.error),);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
