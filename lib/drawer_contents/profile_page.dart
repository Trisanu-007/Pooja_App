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
    final user = Provider.of<Authenticate>(context);
    return FutureBuilder(
      future: UserDatabase(uid: user.uid).userProfileFromDatabase(uid: user.uid),
      // ignore: missing_return
      builder: (context, snapshot) {
        if(snapshot.hasData){
          if(snapshot.data == null){
            return UpdateUserProfile(snapshot: snapshot,);
          }else if(snapshot.data != null){
            return UpdateUserProfile(snapshot: snapshot,);
          }
        }else if(snapshot.hasError){
          return Error();
        }else if(snapshot.connectionState == ConnectionState.waiting){
          return Loading();
        }return Loading();
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
        title: Text("My Profile", style: GoogleFonts.lato()),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Change your Profile Data : ",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
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
                    padding: EdgeInsets.all(10.0),
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
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
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
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
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
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Change Email-Id:",
              style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic),
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
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Current email-Id: ${profile.email_id}",
                          hintText: "Enter updated email"),
                      autovalidate: true,
                      onSaved: (val) => emailId = val,
                    ),
                  ),
                  Text(
                    "Current Password: ",
                    style: GoogleFonts.comfortaa(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                      autovalidate: true,
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
                      error_4 = "Email updated";
                    });
                  else
                    error_4 = "Please try again";
                }
              },
            ),
          ),
          Container(
            child: Text("$error_4"),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _formKeys[5],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone number:",
                    style: GoogleFonts.comfortaa(),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter your phone number",
                    ),
                    keyboardType: TextInputType.number,
                    autovalidate: true,
                    onSaved: (newValue) => mobileNum = int.parse(newValue),
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
                    setState() => error_5 = "Phone number updated";
                  } else {
                    setState() => error_5 = "PLease try again";
                  }
                }
              },
            ),
          ),
          Container(
            child: Text("$error_5"),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _formKeys[6],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Change your password:",
                    style: GoogleFonts.comfortaa(),
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     hintText: "Enter your phone number",
                  //   ),
                  //   keyboardType: TextInputType.number,
                  //   autovalidate: true,
                  //   onSaved: (newValue) => mobileNum = int.parse(newValue),
                  // ),
                ],
              ),
            ),
          ),
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
                if (_formKeys[6].currentState.validate()) {
                  _formKeys[6].currentState.save();
                  dynamic ans =
                      Authenticate().resetUserPassword(profile.email_id.trim());
                  if (ans != null) {
                    setState() => error_6 =
                        "A Password reset link has been sent to your e-mail : ${profile.email_id}";
                  } else {
                    setState() => error_6 = "PLease try again";
                  }
                }
              },
            ),
          ),
          Container(
            child: Text("$error_6"),
          ),
        ],
      ),
    );
  }
}
