import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:durga_pooja/database_services/database.dart';
import 'package:durga_pooja/database_services/user_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  UserProfile userProfile = new UserProfile();

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
      } else {
        cost = cost +
            ((widget.mealsList.getMealCard()[i].if_guest ? 300 : 200) *
                widget.mealsList.getMealCard()[i].count);
      }
    }
    setState(() {
      _totalMeals = _tcoupons;
      _totalCost = cost;
      email = userProfile.email_id;
      mobileNum = userProfile.mobile_num.toString();
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

  void openCheckout() async {
    var options = {
      "key": "rzp_test_LUz3nvkwacrQ9K",
      "amount": _totalCost * 100,
      "name": "Payment for the meals",
      "description": "Test payment",
      "prefill": {"contact": mobileNum ?? '', "email": email ?? ''},
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
    //var mealsList = Provider.of<MealCardList>(context);

    for (var i = 0; i < widget.mealsList.getMealCard().length; i++)
      print(
          "${widget.mealsList.getMealCard()[i].day}  ${widget.mealsList.getMealCard()[i].if_veg}  ${widget.mealsList.getMealCard()[i].if_guest}  ${widget.mealsList.getMealCard()[i].count}");

    print("-------$_totalCost ------------");
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
                Text("S.no."),
                Text("Day"),
                Text("Veg/Non-Veg"),
                Text("Time"),
                Text("Count"),

                //Text("Cost"),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Flexible(
              child: ListView.builder(
                itemCount: widget.mealsList.getMealCard().length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("${index + 1}"),
                      Text("${widget.mealsList.getMealCard()[index].day}"),
                      !widget.mealsList.getMealCard()[index].if_veg
                          ? Text("VEG")
                          : Text("NON-VEG"),
                      widget.mealsList.getMealCard()[index].isBreakfast
                          ? Text("B")
                          : widget.mealsList.getMealCard()[index].isLunch
                              ? Text("L")
                              : Text("D"),
                      Text("${widget.mealsList.getMealCard()[index].count}"),
                      //Text("Rs. 50"), // TODO: Change the cost here
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
                  Text(
                    "Pay using Razorpay",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Icon(Icons.payment),
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.purpleAccent, width: 5.0)),
              onPressed: () {
                openCheckout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
