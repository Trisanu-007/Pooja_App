import 'dart:ui';
import 'package:durga_pooja/database_services/user_database.dart';
import 'package:durga_pooja/shared_resources/authenticate.dart';
import 'package:durga_pooja/shared_resources/loading.dart';
import 'package:durga_pooja/shared_resources/error_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../shared_resources/hex_color.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Authenticate>(context);
    return StreamBuilder(
      stream: UserDatabase(uid: user.uid).getUserProfile,
      //UserDatabase(uid: user.uid).userProfileFromDatabase(uid: user.uid),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return UpdateUserProfile(
              snapshot: snapshot,
            );
          } else if (snapshot.data != null) {
            return UpdateUserProfile(
              snapshot: snapshot,
            );
          }
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Error();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }
        //return Loading();
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
  String password;
  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
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
  String error_7 = "";

  @override
  Widget build(BuildContext context) {
    UserProfile profile = widget.snapshot.data;
    final user = Provider.of<Authenticate>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#0D30F2'),
        title: Text(
          "My Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: HexColor("#F2CF0D"),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Change your Profile Data : ",
                style: TextStyle(
                  color: Colors.black, //grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
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
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      //color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: profile.fullName,
                        ),
                        validator: (val) {
                          if (val.isEmpty) return "PLease fill in your name";
                          return null;
                        },
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
                      //width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        "$error_1",
                        style: TextStyle(
                          color: error_1 == "Name updated"
                              ? Colors.green[800]
                              : Colors.red[800],
                          backgroundColor: (error_1 == "Name updated")
                              ? Colors.greenAccent[100]
                              : Colors.redAccent[100],
                        ),
                      ),
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
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: profile.flatnum,
                        ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please fill in valid Flatnum";
                          }
                          return null;
                        },
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
                          if (ans == null && ans != "")
                            setState(() {
                              error_2 = "Flatnum updated";
                            });
                          else
                            error_2 = "Please try again";
                        }
                      },
                    ),
                    Container(
                      child: Text(
                        "$error_2",
                        style: TextStyle(
                          color: error_2 == "Flatnum updated"
                              ? Colors.green[800]
                              : Colors.red[800],
                          backgroundColor: (error_2 == "Flatnum updated")
                              ? Colors.greenAccent[100]
                              : Colors.redAccent[100],
                        ),
                      ),
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
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: profile.flatnumber.toString(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please fill in valid Flat Number";
                          }
                          return null;
                        },
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
                      child: Text(
                        "$error_3",
                        style: TextStyle(
                          color: error_3 == "Flatnumber updated"
                              ? Colors.green[800]
                              : Colors.red[800],
                          backgroundColor: (error_3 == "Flatnumber updated")
                              ? Colors.greenAccent[100]
                              : Colors.redAccent[100],
                        ),
                      ),
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
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: profile.type,
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please fill in your type(Owner/Not Owner)";
                          }
                          return null;
                        },
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
                      child: Text(
                        "$error_4",
                        style: TextStyle(
                          color: error_4 == "Type updated"
                              ? Colors.green[800]
                              : Colors.red[800],
                          backgroundColor: (error_4 == "Type updated")
                              ? Colors.greenAccent[100]
                              : Colors.redAccent[100],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Change Email,Password,Mobile Number : ",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              thickness: 3.0,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Change Email-Id:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Form(
                key: _formKeys[4],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Updated Email-Id: ",
                      style: GoogleFonts.comfortaa(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Current email-Id: ${profile.email_id}",
                            hintText: "Enter new email"),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Fill in your new email";
                          }
                          return null;
                        },
                        onSaved: (val) => emailId = val,
                      ),
                    ),
                    Text(
                      "Current Password: ",
                      style: GoogleFonts.comfortaa(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter password",
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Enter current password";
                          }
                          return null;
                        },
                        obscureText: true,
                        onSaved: (val) => password = val,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: RaisedButton(
                child: Text(
                  "Update Email-Id",
                  style: GoogleFonts.comfortaa(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                color: Colors.purple,
                onPressed: () async {
                  if (_formKeys[4].currentState.validate()) {
                    _formKeys[4].currentState.save();
                    dynamic res = Authenticate().updateUserEmail(
                        emailId.trim(), profile.email_id.trim(), password);
                    dynamic ans = await UserDatabase(uid: user.uid)
                        .updateUserEmailId(emailId.trim());
                    if (ans == null && res != null)
                      setState(() {
                        error_5 = "Email updated";
                      });
                    else
                      error_5 = "Please try again";
                  }
                },
              ),
            ),
            Container(
              child: Text(
                "$error_5",
                style: TextStyle(
                  color: error_5 == "Type updated"
                      ? Colors.green[800]
                      : Colors.red[800],
                  backgroundColor: (error_5 == "Type updated")
                      ? Colors.greenAccent[100]
                      : Colors.redAccent[100],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: _formKeys[5],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Change your Phone number:",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter your phone number(Without +91)",
                        ),
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Enter new phone number (Without the +91)";
                          }
                          return null;
                        },
                        onSaved: (newValue) => mobileNum = int.parse(newValue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: RaisedButton(
                child: Text(
                  "Update Phone Number",
                  style: GoogleFonts.comfortaa(),
                ),
                textColor: Colors.white,
                color: Colors.purple,
                onPressed: () {
                  if (_formKeys[5].currentState.validate()) {
                    _formKeys[5].currentState.save();
                    dynamic ans = UserDatabase(uid: user.uid)
                        .updateUserMobileNumber(mobileNum);
                    if (ans == null) {
                      setState() => error_6 = "Phone number updated";
                    } else {
                      setState() => error_6 = "Please try again";
                    }
                  }
                },
              ),
            ),
            Container(
              child: Text(
                "$error_6",
                style: TextStyle(
                  color: error_6 == "Type updated"
                      ? Colors.green[800]
                      : Colors.red[800],
                  backgroundColor: (error_6 == "Type updated")
                      ? Colors.greenAccent[100]
                      : Colors.redAccent[100],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Change your password:",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: EdgeInsets.all(5),
              color: Colors.blue[100],
              child: Text(
                "This will send a mail to your current email-id from where you can proceed to change your password.",
                style: TextStyle(color: Colors.indigo),
              ),
            ),
            Container(
              //padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: RaisedButton(
                        child: Text(
                          "Update Password",
                          style: GoogleFonts.comfortaa(),
                        ),
                        textColor: Colors.white,
                        color: Colors.purple,
                        onPressed: () {
                          //if (_formKeys[6].currentState.validate()) {
                          //_formKeys[6].currentState.save();
                          dynamic ans = Authenticate()
                              .resetUserPassword(profile.email_id.trim());
                          if (ans == null) {
                            setState() => error_7 =
                                "A Password reset link has been sent to your e-mail : ${profile.email_id}";
                          } else {
                            setState() => error_7 = "Please try again";
                          }
                        }
                        // },
                        ),
                  ),
                  Container(
                    child: Text(
                      "$error_7",
                      style: TextStyle(
                        color: error_7 == "Type updated"
                            ? Colors.green[800]
                            : Colors.red[800],
                        backgroundColor: (error_7 == "Type updated")
                            ? Colors.greenAccent[100]
                            : Colors.redAccent[100],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
