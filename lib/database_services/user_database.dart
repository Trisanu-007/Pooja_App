import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String flatnum;
  final int flatnumber;
  final int mobile_num;
  final String email_id;
  final String type;
  UserProfile(
      {this.email_id,
      this.flatnum,
      this.flatnumber,
      this.mobile_num,
      this.type});
}

class UserDatabase {
  final String uid;
  UserDatabase({this.uid});

  final CollectionReference userDataCollection =
      Firestore.instance.collection("users");

  Future createUserProfile() async {
    return await userDataCollection.document(uid).setData({
      "flatnum": "Enter flat number here",
      "flatnumber": 0,
      "mobile_num": 0,
      "email_id": "Your Email id",
      "type": "owner/" //TODO: Find the option and change here
    });
  }

  UserProfile convertToUserProfile(DocumentSnapshot snapshot) {
    return snapshot != null
        ? UserProfile(
            flatnum: snapshot.data["flatnum"],
            flatnumber: snapshot.data["flatnumber"],
            mobile_num: snapshot.data["mobile_num"],
            email_id: snapshot.data["email_id"],
            type: snapshot.data["type"],
          )
        : null;
  }

  Stream<UserProfile> get getUserProfile {
    return userDataCollection
        .document(uid)
        .snapshots()
        .map(convertToUserProfile);
  }
}
