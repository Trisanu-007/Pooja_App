import 'package:flutter/material.dart';
import 'package:durga_pooja/drawer_contents/helper_classes.dart';

class CheckOut extends StatefulWidget {
  final mealsList;
  CheckOut({this.mealsList});
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    //var mealsList = Provider.of<MealCardList>(context);
    for(var i=0;i<widget.mealsList.getMealCard().length;i++)
      print("${widget.mealsList.getMealCard()[i].day}  ${widget.mealsList.getMealCard()[i].if_veg}  ${widget.mealsList.getMealCard()[i].if_guest}  ${widget.mealsList.getMealCard()[i].count}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Check out"),
      ),
      body: Container(),
    );
  }
}
