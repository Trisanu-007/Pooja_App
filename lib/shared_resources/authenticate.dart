import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:durga_pooja/database_services/database.dart';
import 'package:durga_pooja/database_services/user_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class CurrentUser {
  final String uid;
  CurrentUser({this.uid});
}

class Authenticate {

  String uid;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<FirebaseUser> get onAuthStateChange => _firebaseAuth.onAuthStateChanged;

  //Converting to user class
  CurrentUser _convertToCurrentUser(FirebaseUser user) {
    return user != null ? CurrentUser(uid: user.uid) : null;
  }

  //Gets the current user
  Future<FirebaseUser> getCurrentUser() async{
    try{
      return _firebaseAuth.currentUser();
    }catch(e){
      print(e);
      return e;
    }
  }

  //For registering the user into the app
  Future register(String password, String email) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).createUserDataInitial(0);
      await UserDatabase(uid: user.uid).createUserProfile("Full Name here",
          "Enter flat number here", 0, 0, user.email, "owner/tenant");
      return _convertToCurrentUser(user);
    } on PlatformException catch (error) {
      print(error);
      return error.toString();
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

  //For signing into the app
  Future signIn(String password, String email) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      FirebaseUser user = result.user;
      this.uid = user.uid;
      print(user);
      return _convertToCurrentUser(user);
    } on PlatformException catch (error) {
      print(error);
      return error.toString();
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

  // For SignUp

  Future signUp(Map<String, dynamic> userMap) async{
    try{
      AuthResult user = await _firebaseAuth.createUserWithEmailAndPassword(email: userMap['email_id'], password: userMap['password']);
      Firestore.instance.collection('users').document('${user.user.uid}').setData(userMap);
      this.uid = user.user.uid;
    }catch(e){
      print(e);
      return e;
    }
  }

  //For signing out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future updateUserEmail(
      String newEmail, String oldEmail, String password) async {
    try {
      print(newEmail);
      return _firebaseAuth
          .signInWithEmailAndPassword(email: oldEmail, password: password)
          .then(
            (user) => user.user.updateEmail(newEmail),
          );
    } on PlatformException catch (err) {
      return err.toString();
    }
  }

  Future resetUserPassword(String email) async {
    try {
      return _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (err) {
      return "Fault";
    }
  }

  Stream<CurrentUser> get user {
    return _firebaseAuth.onAuthStateChanged.map(_convertToCurrentUser);
  }
}
