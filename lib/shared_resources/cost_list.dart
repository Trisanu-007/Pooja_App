import 'dart:ui';
import 'package:durga_pooja/shared_resources/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'hex_color.dart';

class CostList extends StatefulWidget {
  @override
  _CostListState createState() => _CostListState();
}

class _CostListState extends State<CostList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cost List"),
        backgroundColor: HexColor('#0D30F2'),
      ),
      body: Container(
        color: HexColor("#F2CF0D"),
        child: ListView.builder(
          itemCount: costMap.length,
          itemBuilder: (context, index) {
            var val = costMap[index].keys.elementAt(0);
            print(costMap[index].keys.elementAt(0));
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 5, 10.0, 5.0),
                    child: Text(
                      "Day: ${costMap[index].keys.elementAt(0).toUpperCase()}",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 5, 10.0, 5.0),
                    child: Text(
                      "Lunch :",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30.0, 5, 10.0, 5.0),
                    child: Text(
                      "VEG :",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40.0, 5, 10.0, 5.0),
                    child: Text(
                      "For resident: Rs. ${costMap[index][val]["lunch"]["veg"]["resi"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40.0, 5, 10.0, 5.0),
                    child: Text(
                      "For guest: Rs. ${costMap[index][val]["lunch"]["veg"]["guest"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30.0, 5, 10.0, 5.0),
                    child: Text(
                      "NON-VEG :",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40.0, 5, 10.0, 5.0),
                    child: Text(
                      "For resident: Rs. ${costMap[index][val]["lunch"]["non-veg"]["resi"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40.0, 5, 10.0, 5.0),
                    child: Text(
                      "For guest: Rs. ${costMap[index][val]["lunch"]["non-veg"]["guest"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 5, 10.0, 5.0),
                    child: Text(
                      "Dinner :",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30.0, 5, 10.0, 5.0),
                    child: Text(
                      "VEG :",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40.0, 5, 10.0, 5.0),
                    child: Text(
                      "For resident: Rs. ${costMap[index][val]["dinner"]["veg"]["resi"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40.0, 5, 10.0, 5.0),
                    child: Text(
                      "For guest: Rs. ${costMap[index][val]["dinner"]["veg"]["guest"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30.0, 5, 10.0, 5.0),
                    child: Text(
                      "NON-VEG :",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40.0, 5, 10.0, 5.0),
                    child: Text(
                      "For resident: Rs. ${costMap[index][val]["dinner"]["non-veg"]["resi"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40.0, 5, 10.0, 5.0),
                    child: Text(
                      "For guest: Rs. ${costMap[index][val]["dinner"]["non-veg"]["guest"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
