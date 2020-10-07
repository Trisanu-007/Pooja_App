import 'dart:ui';
import 'package:flutter/material.dart';
import 'hex_color.dart';

class UseInfo extends StatefulWidget {
  @override
  _UseInfoState createState() => _UseInfoState();
}

class _UseInfoState extends State<UseInfo> {
  List<String> _instructions = [
    "Make sure after you have signed in you go to \"My Profile\" and update all the relevant info there . ",
    "After that you can go to \"Buy Coupons\" and then buy the coupons there. We recommend buying 1 day's worth meal at a time.",
    "Press the checkout button at the top. Check the meal information from the table and click \"Pay using Razorpay\".",
    "If you had updated your info before, your email-id and phone number should show up now. If not then you can fill on your own.",
    "Your transactions will show up in \"My coupons \"",
    "You can check the costs in \"Cost list\" .",
    "If something goes wrong, please contact the admin ."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How to use the app"),
        centerTitle: true,
        backgroundColor: HexColor('#0D30F2'),
      ),
      body: Container(
        color: HexColor("#F2CF0D"),
        child: Stack(
          children: [
            Container(width: 10.0,color: HexColor('#0D30F2'),margin: EdgeInsets.fromLTRB(46, 0, 0, 0),),
            ListView.builder(
              itemCount: _instructions.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 5, 20),
                      child: CircleAvatar(
                        backgroundColor: HexColor('#0D30F2'),
                        radius: 30.0,
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,),
                        ),
                      ),
                    ),
                    Container(
                      //color:HexColor("#F2CF0D"),
                      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                      width: MediaQuery.of(context).size.width - 90.0,
                      //margin: EdgeInsets.fromLTRB(5, 20, 200, 20),
                      child: Card(
                        color: HexColor("#F2CF0D"),
                        elevation: 0.0,
                        child: Text(
                          "${_instructions[index]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
