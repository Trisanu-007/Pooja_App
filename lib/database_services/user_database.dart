import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String fullName;
  final String flatnum;
  final int flatnumber;
  final int mobile_num;
  final String email_id;
  final String password;
  final String type;
  UserProfile(
      {this.fullName,
      this.email_id,
      this.flatnum,
      this.flatnumber,
      this.mobile_num,
      this.type,
      this.password});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        fullName: json['fullName'],
        flatnum: json['flatnum'],
        flatnumber: json['flatnumber'] ?? 35,
        mobile_num: json['mobile_num'],
        email_id: json['email_id'],
        type: json['type'] ?? "owner",
        password: json['password']);
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'flatnum': flatnum,
      'flatnumber': flatnumber ?? 35,
      'mobile_num': mobile_num,
      'email_id': email_id,
      'type': type ?? "owner",
      'password': password
    };
  }
}

class UserDatabase {
  final String uid;
  UserDatabase({this.uid});

  final CollectionReference userDataCollection =
      Firestore.instance.collection("users");

  Future createUserProfile(String fullName, String flatNum, int flatNumber,
      int mobileNum, String emailId, String type) async {
    return await userDataCollection.document(uid).setData(
      {
        "fullname": fullName,
        "flatnum": flatNum,
        "flatnumber": flatNumber,
        "mobile_num": mobileNum,
        "email_id": emailId,
        "type": type,
      },
    );
  }

  Future updateUserName(String name) async {
    try {
      return await userDataCollection.document(uid).updateData({
        "fullName": name,
      });
    } catch (e) {
      print("error");
      return e;
    }
  }

  Future updateUserFlatNum(String flatnum) async {
    try {
      return await userDataCollection.document(uid).updateData({
        "flatnum": flatnum,
      });
    } catch (e) {
      print("error");
      return e;
    }
  }

  Future updateFlatNumber(int flatNumber) async {
    try {
      return await userDataCollection.document(uid).updateData({
        "flatnumber": flatNumber,
      });
    } catch (e) {
      print("error");
      return e;
    }
  }

  Future updateUserMobileNumber(int mobileNum) async {
    try {
      return await userDataCollection.document(uid).updateData({
        "mobile_num": mobileNum,
      });
    } catch (e) {
      print("error");
      return e;
    }
  }

  Future updateUserType(String type) async {
    try {
      return await userDataCollection.document(uid).updateData({
        "type": type,
      });
    } catch (e) {
      print("error");
      return e;
    }
  }

  Future updateUserEmailId(String newEmailId) async {
    try {
      return await userDataCollection.document(uid).updateData({
        "email_id": newEmailId,
      });
    } catch (e) {
      print("error");
      return e;
    }
  }

  UserProfile convertToUserProfile(DocumentSnapshot snapshot) {
    return snapshot != null
        ? UserProfile(
            fullName: snapshot.data["fullName"],
            flatnum: snapshot.data["flatnum"],
            flatnumber: snapshot.data["flatnumber"],
            mobile_num: snapshot.data["mobile_num"],
            email_id: snapshot.data["email_id"],
            type: snapshot.data["type"],
          )
        : null;
  }

  Future<UserProfile> userProfileFromDatabase({String uid}) async {
    try {
      DocumentSnapshot snapshot =
          await Firestore.instance.collection("users").document(uid).get();
      Map<String, dynamic> userMap = snapshot.data;
      return UserProfile.fromJson(userMap);
    } catch (e) {
      print(e);
      return e;
    }
  }

  Stream<UserProfile> get getUserProfile {
    return userDataCollection
        .document(uid)
        .snapshots()
        .map(convertToUserProfile);
  }
}
