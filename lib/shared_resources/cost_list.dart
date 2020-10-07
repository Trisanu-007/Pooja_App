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
  /*
  List<Map<String, dynamic>> costMap = [
    {
      "sasthi": {
        "lunch": {
          "veg": {"resi": 0, "guest": 0},
          "non-veg": {"resi": 0, "guest": 0}
        },
        "dinner": {
          "veg": {"resi": 80, "guest": 120},
          "non-veg": {"resi": 0, "guest": 0}
        },
      },
    },
    {
      "saptami": {
        "lunch": {
          "veg": {"resi": 60, "guest": 120},
          "non-veg": {"resi": 70, "guest": 150}
        },
        "dinner": {
          "veg": {"resi": 100, "guest": 150},
          "non-veg": {"resi": 120, "guest": 150}
        }
      },
    },
    {
      "astami": {
        "lunch": {
          "veg": {"resi": 50, "guest": 100},
          "non-veg": {"resi": 0, "guest": 0}
        },
        "dinner": {
          "veg": {"resi": 80, "guest": 120},
          "non-veg": {"resi": 0, "guest": 0}
        }
      },
    },
    {
      "nabami": {
        "lunch": {
          "veg": {"resi": 80, "guest": 150},
          "non-veg": {"resi": 100, "guest": 250}
        },
        "dinner": {
          "veg": {"resi": 120, "guest": 150},
          "non-veg": {"resi": 130, "guest": 170}
        }
      },
    },
    {
      "dasami": {
        "lunch": {
          "veg": {"resi": 60, "guest": 120},
          "non-veg": {"resi": 70, "guest": 150}
        },
        "dinner": {
          "veg": {"resi": 120, "guest": 150},
          "non-veg": {"resi": 200, "guest": 300}
        }
      },
    },
  ];
   */

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
