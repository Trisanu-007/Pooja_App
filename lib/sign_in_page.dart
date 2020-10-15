import 'dart:ui';
import 'package:durga_pooja/database_services/user_database.dart';
import 'package:durga_pooja/shared_resources/authenticate.dart';
import 'package:durga_pooja/shared_resources/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  String error1 = "";
  String error2 = "";

  bool signIn = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _flatNumberController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Authenticate authenticate = Provider.of<Authenticate>(context);

    return Scaffold(
      backgroundColor: HexColor("#F2CF0D"),
      appBar: AppBar(
        backgroundColor: HexColor("#F2CF0D"),
        elevation: 0,
        /*
        actions: [
          !signIn
              ? FlatButton(
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  onPressed: () {
                    setState(() {
                      signIn = !signIn;
                    });
                  },
                )
              : SizedBox()
        ],
         */
      ),
      body: Form(
        key: _formKey,
        child: signIn
            ? Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 3 / 5,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
                  ),
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          'Pooja App',
                          style: GoogleFonts.droidSerif(
                              fontSize: 40,
                              color: HexColor("#0D30F2"),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (String val) {
                          if (val.isEmpty) {
                            return "This field is required";
                          } else {
                            return "";
                          }
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (String val) {
                          if (val.isEmpty) {
                            return "This field is required";
                          }
                          return "";
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        color: Colors.purple,
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        onPressed: () async {
                          //if(_formKey.currentState.validate())  {
                          dynamic res = await authenticate.signIn(
                              _passwordController.text, _emailController.text);
                          //}
                          if(res==null){
                            setState(() {
                              error1 = res;
                            });
                          }
                        },
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text(error1,style: TextStyle(color: Colors.red,fontSize: 15.0,),),
                      ),

                      RaisedButton(
                        color: Colors.purple,
                        child: Text(
                          'Create Account ?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            signIn = !signIn;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)]),
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        'Pooja App',
                        style: GoogleFonts.droidSerif(
                            fontSize: 40,
                            color: HexColor("#4133CC"),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(labelText: 'Full Name'),
                      validator: (String val) {
                        if (val.isEmpty) {
                          return "This field is required";
                        }
                        return "";
                      },
                    ),
                    TextFormField(
                      controller: _flatNumberController,
                      decoration: InputDecoration(labelText: 'Flat Number'),
                      validator: (String val) {
                        if (val.isEmpty) {
                          return "This field is required";
                        }
                        return "";
                      },
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      validator: (String val) {
                        if (val.isEmpty) {
                          return "This field is required";
                        }
                        return "";
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (String val) {
                        if (val.isEmpty) {
                          return "This field is required";
                        } else {
                          return "";
                        }
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (String val) {
                        if (val.isEmpty) {
                          return "This field is required";
                        }
                        return "";
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      color: Colors.purple,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 17.0),
                      ),
                      onPressed: () async {
                        _formKey.currentState.validate();
                        UserProfile user = UserProfile(
                          password: _passwordController.text,
                          email_id: _emailController.text,
                          mobile_num: int.parse(_phoneNumberController.text),
                          flatnum: _flatNumberController.text,
                          fullName: _fullNameController.text,
                        );
                        dynamic res = await authenticate.signUp(user.toMap());
                        if(res!=null) {
                          setState(() {
                            error2 = res;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    !signIn
                        ? RaisedButton(
                            color: Colors.purple,
                            child: Text(
                              'Sign In ?',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            onPressed: () {
                              setState(() {
                                signIn = !signIn;
                              });
                            },
                          )
                        : SizedBox(),
                    Container(
                      child: Text(error2,style: TextStyle(color: Colors.red),),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
