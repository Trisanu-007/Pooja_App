import 'package:durga_pooja/drawer_contents/per_coupon_data.dart';
import 'package:flutter/material.dart';

class PastTokensList extends StatelessWidget {
  final transId;
  final couponJson;
  PastTokensList({this.couponJson, this.transId});

  @override
  Widget build(BuildContext context) {
    print(couponJson);
    return Scaffold(
      appBar: AppBar(
        title: Text("$transId"),
      ),
      body: ListView.builder(
        itemCount: couponJson.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              isThreeLine: true,
              leading: Icon(Icons.payment, color: Colors.blue[600]),
              title: Text(
                  "${couponJson[index]["day"]}, Count: ${couponJson[index]["count"]}"),
              subtitle: Text(
                  "Meal Type: ${couponJson[index]["is_guest"]}, ${couponJson[index]["is_veg"]}"),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PerCouponData()));
              },
            ),
          );
        },
      ),
    );
  }
}
