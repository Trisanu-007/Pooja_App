import 'package:durga_pooja/drawer_contents/per_coupon_data.dart';
import 'package:flutter/material.dart';
import '../shared_resources/hex_color.dart';

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
        backgroundColor: HexColor('#0D30F2'),
      ),
      body: Container(
        color: HexColor("#F2CF0D"),
        child: ListView.builder(
          itemCount: couponJson.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
              margin: EdgeInsets.all(10.0),
              child: ListTile(
                isThreeLine: true,
                leading: Hero(
                  tag: "Pay-$index",
                  child: CircleAvatar(
                    child: Icon(
                      Icons.payment,
                      color: Colors.white,
                    ),
                  ),
                ),
                trailing: Container(
                  child: Text(
                    "PAID",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                    "${couponJson[index]["day"]}, Count: ${couponJson[index]["count"]}"),
                subtitle: Text(
                    "Meal Type: ${couponJson[index]["is_guest"]}, ${couponJson[index]["is_veg"]}, Time: ${couponJson[index]["time"]}"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PerCouponData(
                        jsonData: couponJson[index],
                        index: index,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
