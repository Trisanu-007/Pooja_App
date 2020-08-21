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
  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushNamed(context, "buyCoupons");
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
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            Container(
              child: Center(
                child: Text(
                  "Welcome to EHCSC",
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              width: MediaQuery.of(context).size.width,
            ),
            Image(
              image: AssetImage("assets/ehcbc.jpeg"),
              width: MediaQuery.of(context).size.width,
            ),
            AlertDialog(
              title: Text(
                  "Please update your User data in the \"My Profile\" section before making any purchases"),
              actions: [
                RaisedButton(
                    child: Text("My Profile"),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ));
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
