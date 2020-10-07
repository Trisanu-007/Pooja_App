import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:durga_pooja/database_services/database.dart';
import 'package:durga_pooja/database_services/user_database.dart';
import 'package:durga_pooja/shared_resources/authenticate.dart';
import 'package:durga_pooja/shared_resources/loading.dart';
import 'package:durga_pooja/shared_resources/error_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  final mealsList;
  CheckOut({this.mealsList});
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  var _totalMeals = 0;
  var _totalCost = 0;
  String email;
  String mobileNum;
  Razorpay _razorpay;
  Firestore firestoreInstance;
  UserProfile userProfile;
  List<int> costPerMeal = [];

  @override
  void initState() {
    super.initState();
    var _tcoupons = 0;
    var cost = 0;
    for (var i = 0; i < widget.mealsList.getMealCard().length; i++) {
      _tcoupons += widget.mealsList.getMealCard()[i].count;
      if (!widget.mealsList.getMealCard()[i].if_veg) {
        cost = cost +
            ((widget.mealsList.getMealCard()[i].if_guest ? 200 : 100) *
                widget.mealsList.getMealCard()[i].count);
        costPerMeal.add(
            (widget.mealsList.getMealCard()[i].if_guest ? 200 : 100) *
                widget.mealsList.getMealCard()[i].count);
      } else {
        cost = cost +
            ((widget.mealsList.getMealCard()[i].if_guest ? 300 : 200) *
                widget.mealsList.getMealCard()[i].count);
        costPerMeal.add(
            (widget.mealsList.getMealCard()[i].if_guest ? 300 : 200) *
                widget.mealsList.getMealCard()[i].count);
      }
    }
    setState(() {
      _totalMeals = _tcoupons;
      _totalCost = cost;
      //email = userProfile.email_id;
      //mobileNum = userProfile.mobile_num.toString();
    });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(UserProfile profile) async {
    var options = {
      "key": "rzp_test_LUz3nvkwacrQ9K",
      "amount": _totalCost * 100,
      "name": "Payment for the meals",
      "description": "Test payment",
      "prefill": {
        "contact": profile.mobile_num ?? '',
        "email": profile.email_id ?? ''
      },
      "external": {
        "wallets": ["paytm"],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    DatabaseService _databaseService = DatabaseService(uid: firebaseUser.uid);
    await _databaseService.createTransactionInDatabase(
        response, widget.mealsList, _totalCost);
    Fluttertoast.showToast(msg: "SUCCESS" + response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR" + response.code.toString() + "->" + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET" + response.walletName);
  }

  Widget build(BuildContext context) {
    //_asyncMethod(context);
    final user = Provider.of<Authenticate>(context);
    return StreamBuilder<UserProfile>(
        stream: UserDatabase(uid: user.uid).getUserProfile,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Loading();
          if (snapshot.connectionState == ConnectionState.none) return Error();
          if (snapshot.hasError) return Error();
          UserProfile profile = snapshot.data;
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) return Error();
            return Scaffold(
              appBar: AppBar(
                title: Text("Check out"),
              ),
              body: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            "Total number of coupons are : ",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            "$_totalMeals",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            "Total cost of all coupons is : ",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            "Rs. $_totalCost",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "S.no.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.indigoAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Day",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigoAccent,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Veg/Non-Veg",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigoAccent,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Time",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.indigoAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Count",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigoAccent,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Cost",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigoAccent,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        //Text("Cost"),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Flexible(
                      child: ListView.builder(
                        itemCount: widget.mealsList.getMealCard().length,
                        itemBuilder: (context, index) {
                          return Row(
                            //mainAxisAlignment: MainAxisAlignment.values[10,20,30,20,10],
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 5.0, 20.0, 5.0),
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${widget.mealsList.getMealCard()[index].day}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              !widget.mealsList.getMealCard()[index].if_veg
                                  ? Expanded(
                                      child: Icon(
                                        Icons.fiber_manual_record,
                                        color: Colors.green,
                                      ),
                                    )
                                  : Expanded(
                                      child: Icon(
                                        Icons.fiber_manual_record,
                                        color: Colors.red,
                                      ),
                                    ),
                              widget.mealsList.getMealCard()[index].isBreakfast
                                  ? Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 0.0, 10.0, 0.0),
                                        child: Text(
                                          "Breakfast",
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    )
                                  : widget.mealsList
                                          .getMealCard()[index]
                                          .isLunch
                                      ? Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                25, 0.0, 10.0, 0.0),
                                            child: Text(
                                              "Lunch",
                                              style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ))
                                      : Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                25, 0.0, 10.0, 0.0),
                                            child: Text(
                                              "Dinner",
                                              style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                              Expanded(
                                //flex: 1,
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(20, 0.0, 10.0, 0.0),
                                  child: Text(
                                      "${widget.mealsList.getMealCard()[index].count}",
                                    style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 0.0, 10.0, 0.0),
                                  child: Text("Rs. ${costPerMeal[index]}",
                                    style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.all(10.0),
                      elevation: 20.0,
                      splashColor: Colors.greenAccent,
                      color: Colors.purple,
                      textColor: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            "Pay using Razorpay",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Colors.purpleAccent, width: 5.0)),
                      onPressed: () {
                        openCheckout(profile);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
