import 'dart:convert';
import 'package:durga_pooja/database_services/database.dart';
import 'package:durga_pooja/drawer_contents/past_tokens_list.dart';
import 'package:durga_pooja/shared_resources/authenticate.dart';
import 'package:durga_pooja/shared_resources/loading.dart';
import 'package:durga_pooja/shared_resources/error_page.dart';
import 'package:durga_pooja/drawer_contents/helper_classes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PastTokens extends StatefulWidget {
  @override
  _PastTokensState createState() => _PastTokensState();
}

class _PastTokensState extends State<PastTokens> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return StreamBuilder<List<CouponData>>(
        stream: DatabaseService(uid: user.uid).couponData ?? "0",
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Loading();
          if (snapshot.connectionState == ConnectionState.none) return Error();
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) return Error();
            if (snapshot.hasData) {
              List<CouponData> couponData = snapshot.data;
              return Scaffold(
                appBar: AppBar(
                  title: Text("My Coupons"),
                ),
                body: ListView.builder(
                  itemCount: couponData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(20.0),
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Transaction-ID : ",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "${couponData[index].payment_id}",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Time of payment : ",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "${couponData[index].transaction_time}",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Time of payment : ",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "Rs. ${couponData[index].total_cost_paid}",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          RaisedButton(
                            child: Text("Check Details"),
                            color: Colors.amber,
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PastTokensList(
                                  couponJson: jsonDecode(
                                    couponData[index].couponAsJson,
                                  ),
                                  transId: couponData[index].payment_id,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              return Text("Please buy some coupons to see them here");
            }
          }
        });
  }
}
