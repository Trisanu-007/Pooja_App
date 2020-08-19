import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:durga_pooja/drawer_contents/helper_classes.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection("coupons_new");

  Future createUserDataInitial(int currNoTrans) async {
    return await userCollection.document(uid).setData({
      "current_no_trans": currNoTrans,
    });
  }

  Future createTransactionInDatabase(PaymentSuccessResponse response,
      MealCardList mealCardList, var totalCost) async {
    var len = await userCollection.document(uid).get().then((value) {
      try {
        return value.data["current_no_trans"] + 1;
      } catch (e) {
        return 0;
      }
    });

    String _mealListToJson = jsonEncode(mealCardList.getMealCard());
    print(_mealListToJson);

    var time = new DateTime.now();
    await userCollection
        .document(uid)
        .collection("transactions")
        .document(response.paymentId)
        .setData({
      "transaction-time": "${DateFormat.jms().format(time)}" +
          " " +
          "${DateFormat.yMMMEd().format(time)}",
      "total_cost_paid": totalCost,
      "coupons": jsonDecode(_mealListToJson),
    }, merge: true).then((_) => print("-----Record success-------"));

    await userCollection.document(uid).updateData({
      "current_no_trans": len,
    });
    //TODO: Find a way to choose the day
  }

  List<CouponData> convertToCouponClass(QuerySnapshot snapshots) {
    return snapshots.documents.map((value) {
      return CouponData(
        payment_id: value.documentID,
        transaction_time: value.data["transaction-time"],
        couponAsJson: jsonEncode(value.data["coupons"]),
      );
    }).toList();
  }

  Stream<List<CouponData>> get couponData {
    return Firestore.instance
        .collection("coupons_new")
        .document(uid)
        .collection("transactions")
        .snapshots()
        .map(convertToCouponClass);
  }
}
