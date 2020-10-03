import 'package:durga_pooja/drawer_contents/buy_tokens.dart';
import 'package:durga_pooja/drawer_contents/past_tokens.dart';
import 'package:durga_pooja/drawer_contents/profile_page.dart';
import 'package:durga_pooja/shared_resources/authenticate.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  showAlert(BuildContext context){

    Widget okClose = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        },
    );

    Widget goToProfile = FlatButton(
      child: Text("My Profile"),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Before you go on ..."),
      content: Text(
          "Please update your User data in the \"My Profile\" section before making any purchases"),
      actions: [
        goToProfile,
        okClose,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //showAlert(context);
    return MaterialApp(
      initialRoute: '/',
      routes: {
        //'/': (context) => HomePage(),
        '/buyCoupons': (context) => HomeBuyTokens(),
      },
      home: Scaffold(
        endDrawer: //_customDrawer(context),
            Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    "Hi",
                    style: TextStyle(color: Colors.white, fontSize: 40.0),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text("My profile"),
                trailing: Icon(Icons.account_circle),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              ListTile(
                title: Text("My Coupons"),
                trailing: Icon(Icons.playlist_add_check),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PastTokens()));
                },
              ),
              ListTile(
                title: Text("Buy Coupons"),
                trailing: Icon(Icons.playlist_add),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeBuyTokens()));
                },
              ),
              ListTile(
                title: Text("Logout"),
                trailing: Icon(Icons.keyboard_tab),
                onTap: () async {
                  await Authenticate().signOut();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Home Page"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    //color: Colors.amberAccent[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(

                    "assets/ehcbc.jpeg",
                    scale: 0.3,
                    width: 500.0,
                    //height: 600,
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      "Welcome to EHCSC",
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
            /*
            Image.asset(
              "assets/ehcbc.jpeg",
              scale: 0.5,
            ),
             */
            //Image(image: AssetImage("assets/ehcbc.jpeg",)),
            AlertDialog(
              title: Text("Before you go ahead ..."),
              content: Text(
                  "Please update your User data in the \"My Profile\" section before making any purchases"),
              actions: [
                RaisedButton(
                  color: Colors.purpleAccent,
                  child: Text("My Profile"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ));
                  },
                ),
                RaisedButton(
                  child: Text("OK"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
