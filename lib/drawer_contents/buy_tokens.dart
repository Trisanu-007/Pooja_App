import 'dart:core';
import 'package:durga_pooja/drawer_contents/helper_classes.dart';
import 'package:durga_pooja/drawer_contents/check_out.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBuyTokens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => MealCardList(
          mealCards: [],
        ),
        child: BuyTokens(),
      ),
    );
  }
}

class BuyTokens extends StatefulWidget {
  final String title;

  BuyTokens({Key key, this.title}) : super(key: key);

  @override
  _BuyTokensState createState() => _BuyTokensState();
}

class _BuyTokensState extends State<BuyTokens> {
  final _formKey = GlobalKey<FormState>();
  String error = "";
  final List<String> events = ["Durga Pooja 2020", "Sports 2020"];
  final List<String> days = [
    "Shashti - 22 Oct",
    "Saptami - 23 Oct",
    "Ashtami - 24 Oct",
    "Navami - 25 Oct",
    "Dashami - 26 Oct",
  ];
  String _currentEvent;

  @override
  Widget build(BuildContext context) {
    var mealsList = Provider.of<MealCardList>(context);
    //print(mealsList);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          RaisedButton(
            color: Colors.amber,
            child: Row(
              children: [
                Text("Check out"),
                Icon(Icons.shopping_cart),
              ],
            ),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CheckOut(mealsList: mealsList))),
          ),
        ],
        //TODO:Apply routes
        /*
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.of(context).pop();
        }),
         */
        title: Text(
          "Buy Tokens",
        ),
      ),
      body: Container(
        color: Colors.amber[100],
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Choose Event",
                style: TextStyle(fontSize: 20.0),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  focusColor: Colors.white,
                  autovalidate: true,
                  validator: (val) {
                    String ans;
                    if (val != null && val.isEmpty) {
                      ans = "Please type in your email";
                    }
                    return ans;
                  },
                  items: events.map((event) {
                    return DropdownMenuItem(
                      value: event,
                      child: Text("$event"),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _currentEvent = val;
                    });
                  },
                  onSaved: (val) {
                    setState(() {
                      _currentEvent = val;
                    });
                  },
                ),
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Text(
                  "Add Meals",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  final formState = _formKey.currentState;
                  if (formState.validate()) {
                    formState.save();
                    Provider.of<MealCardList>(context, listen: false)
                        .addMealCard(MealCard(
                      day: "Shashti - 22 Oct",
                      if_veg: false,
                      if_guest: false,
                      count: 1,
                      isBreakfast: false,
                      isLunch: false,
                      isDinner: false,
                    ));
                  } else {
                    setState(() {
                      error = "Please choose a field above";
                    });
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Total coupons:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  Text(
                    "${mealsList.getMealCard().length}",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ],
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: mealsList.getMealCard().length,
                  itemBuilder: (context, index) {
                    return BuildMeals(index: index, key: ObjectKey(index));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildMeals extends StatefulWidget {
  final index;

  BuildMeals({this.index, Key key}) : super(key: key);

  @override
  _BuildMealsState createState() => _BuildMealsState();
}

class _BuildMealsState extends State<BuildMeals> {
  final List<String> days = [
    "Shashti - 22 Oct",
    "Saptami - 23 Oct",
    "Ashtami - 24 Oct",
    "Navami - 25 Oct",
    "Dashami - 26 Oct",
  ];

  @override
  Widget build(BuildContext context) {
    final mealList = Provider.of<MealCardList>(context);
    return Dismissible(
      key: UniqueKey(), //mealList.getMealCard()[widget.index].id,
      onDismissed: (DismissDirection direction) {
        // Not use it like here (it will not listen to changes)
        mealList.removeMealCard(widget.index);
        //TODO: Confirm dismiss
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Meal Deleted")),
        );
      },
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.centerStart,
      ),
      child: Container(
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
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Choose a day:",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField(
                  value: mealList.getMealCard()[widget.index].day,
                  items: days.map((day) {
                    return DropdownMenuItem(
                      value: day,
                      child: Text("$day"),
                    );
                  }).toList(),
                  onChanged: (val) {
                    Provider.of<MealCardList>(context, listen: false)
                        .updateMealCard(widget.index, val);
                  },
                ),
                SizedBox(
                  width: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Meal Time",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: mealList.getMealCard()[widget.index].isBreakfast
                          ? Colors.purple
                          : Colors.grey[300],
                      child: Text(
                        "Breakfast",
                        style: TextStyle(
                            color:
                                mealList.getMealCard()[widget.index].isBreakfast
                                    ? Colors.white
                                    : Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          Provider.of<MealCardList>(context, listen: false)
                              .changeBreakFastDetails(widget.index);
                        });
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    RaisedButton(
                      color: mealList.getMealCard()[widget.index].isLunch
                          ? Colors.purple
                          : Colors.grey[300],
                      child: Text(
                        "Lunch",
                        style: TextStyle(
                            color: mealList.getMealCard()[widget.index].isLunch
                                ? Colors.white
                                : Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          Provider.of<MealCardList>(context, listen: false)
                              .changeLunchDetails(widget.index);
                        });
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    RaisedButton(
                      color: mealList.getMealCard()[widget.index].isDinner
                          ? Colors.purple
                          : Colors.grey[300],
                      child: Text(
                        "Dinner",
                        style: TextStyle(
                            color: mealList.getMealCard()[widget.index].isDinner
                                ? Colors.white
                                : Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          Provider.of<MealCardList>(context, listen: false)
                              .changeDinnerDetails(widget.index);
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Switch(
                      value: mealList.getMealCard()[widget.index].if_veg,
                      onChanged: (val) {
                        setState(() {
                          Provider.of<MealCardList>(context, listen: false)
                              .getMealCard()[widget.index]
                              .if_veg = val;
                        });
                      },
                      activeTrackColor: Colors.redAccent,
                      activeColor: Colors.white,
                      inactiveTrackColor: Colors.green,
                    ),
                    Container(
                      child: mealList.getMealCard()[widget.index].if_veg
                          ? Text(
                              "NON-VEG",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "VEG",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                      color: mealList.getMealCard()[widget.index].if_veg
                          ? Colors.redAccent
                          : Colors.greenAccent,
                      padding: EdgeInsets.all(2.0),
                    ),
                    Switch(
                      value: mealList.getMealCard()[widget.index].if_guest,
                      onChanged: (val) {
                        setState(() {
                          Provider.of<MealCardList>(context, listen: false)
                              .getMealCard()[widget.index]
                              .if_guest = val;
                        });
                      },
                      activeTrackColor: Colors.deepOrange,
                      activeColor: Colors.white,
                      inactiveTrackColor: Colors.blueAccent,
                    ),
                    Container(
                      child: mealList.getMealCard()[widget.index].if_guest
                          ? Text(
                              "GUEST",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "RESIDENT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                      color: mealList.getMealCard()[widget.index].if_guest
                          ? Colors.deepOrange
                          : Colors.blueAccent,
                      padding: EdgeInsets.all(2.0),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    //Text("Count:"),
                    Container(
                      child: Text(
                        "${mealList.getMealCard()[widget.index].count}",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      color: Colors.grey[300],
                      padding: EdgeInsets.all(5.0),
                    ),
                    ButtonTheme(
                      minWidth: 20.0,
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.lime,
                          child: Icon(Icons.add),
                          onPressed: () {
                            Provider.of<MealCardList>(context, listen: false)
                                .updateMealCardCount(widget.index);
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
