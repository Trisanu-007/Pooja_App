import 'package:durga_pooja/database_services/user_database.dart';
import 'package:durga_pooja/shared_resources/authenticate.dart';
import 'package:durga_pooja/shared_resources/loading.dart';
import 'package:durga_pooja/shared_resources/error_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return StreamBuilder(
      stream: UserDatabase(uid: user.uid).getUserProfile,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Loading();
        if (snapshot.connectionState == ConnectionState.none) return Error();
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) return Error();
          if (snapshot.hasData) {
            //UserProfile profile = snapshot.data;
            return UpdateUserProfile(
              snapshot: snapshot,
            );
          }
        }
      },
    );
  }
}

class UpdateUserProfile extends StatefulWidget {
  final snapshot;
  UpdateUserProfile({this.snapshot});
  @override
  _UpdateUserProfileState createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  String fullName;
  String flatnum;
  int flatNumber;
  int mobileNum;
  String emailId;
  String type;
  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  String error_1 = "";
  String error_2 = "";
  String error_3 = "";
  String error_4 = "";
  String error_5 = "";
  String error_6 = "";

  @override
  Widget build(BuildContext context) {
    UserProfile profile = widget.snapshot.data;
    final user = Provider.of<CurrentUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile", style: GoogleFonts.lato()),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Change your Profile Data : ",
              style: GoogleFonts.comfortaa(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            thickness: 3.0,
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
              key: _formKeys[0],
              child: Column(
                children: [
                  Text(
                    "Full name : ",
                    style: GoogleFonts.comfortaa(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: profile.fullName,
                      ),
                      autovalidate: true,
                      onSaved: (val) => fullName = val,
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      "Update",
                      style: GoogleFonts.comfortaa(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.purple,
                    onPressed: () async {
                      if (_formKeys[0].currentState.validate()) {
                        _formKeys[0].currentState.save();
                        dynamic ans = await UserDatabase(uid: user.uid)
                            .updateUserName(fullName);
                        if (ans == null)
                          setState(() {
                            error_1 = "Name updated";
                          });
                        else
                          error_1 = "Please try again";
                      }
                    },
                  ),
                  Container(
                    child: Text("$error_1"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
              key: _formKeys[1],
              child: Column(
                children: [
                  Text(
                    "FlatNum: ",
                    style: GoogleFonts.comfortaa(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: profile.flatnum,
                      ),
                      autovalidate: true,
                      onSaved: (val) => flatnum = val,
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      "Update",
                      style: GoogleFonts.comfortaa(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.purple,
                    onPressed: () async {
                      if (_formKeys[1].currentState.validate()) {
                        _formKeys[1].currentState.save();
                        dynamic ans = await UserDatabase(uid: user.uid)
                            .updateUserFlatNum(flatnum);
                        if (ans == null)
                          setState(() {
                            error_2 = "Flatnum updated";
                          });
                        else
                          error_2 = "Please try again";
                      }
                    },
                  ),
                  Container(
                    child: Text("$error_2"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
              key: _formKeys[2],
              child: Column(
                children: [
                  Text(
                    "FlatNumber: ",
                    style: GoogleFonts.comfortaa(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: profile.flatnumber.toString(),
                      ),
                      autovalidate: true,
                      onSaved: (val) => flatNumber = int.parse(val),
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      "Update",
                      style: GoogleFonts.comfortaa(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.purple,
                    onPressed: () async {
                      if (_formKeys[2].currentState.validate()) {
                        _formKeys[2].currentState.save();
                        dynamic ans = await UserDatabase(uid: user.uid)
                            .updateFlatNumber(flatNumber);
                        if (ans == null)
                          setState(() {
                            error_3 = "Flatnumber updated";
                          });
                        else
                          error_3 = "Please try again";
                      }
                    },
                  ),
                  Container(
                    child: Text("$error_2"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
              key: _formKeys[3],
              child: Column(
                children: [
                  Text(
                    "Type : ",
                    style: GoogleFonts.comfortaa(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: profile.type),
                      autovalidate: true,
                      onSaved: (val) => type = val,
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      "Update",
                      style: GoogleFonts.comfortaa(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.purple,
                    onPressed: () async {
                      if (_formKeys[3].currentState.validate()) {
                        _formKeys[3].currentState.save();
                        dynamic ans = await UserDatabase(uid: user.uid)
                            .updateUserType(type);
                        if (ans == null)
                          setState(() {
                            error_4 = "Type updated";
                          });
                        else
                          error_4 = "Please try again";
                      }
                    },
                  ),
                  Container(
                    child: Text("$error_4"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Change Email,Password,Mobile Number : ",
              style: GoogleFonts.comfortaa(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            thickness: 3.0,
          ),
        ],
      ),
    );
  }
}
