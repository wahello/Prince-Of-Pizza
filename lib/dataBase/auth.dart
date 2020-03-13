import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Accounts {
  static Future<String> signUpWithEmail(String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return (await FirebaseAuth.instance.currentUser()).uid;
    } catch (error) {
      Fluttertoast.showToast(
          msg: ' Enter Corrent Email or Password ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  static Future<String> signInWithEmail(String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      FirebaseUser user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user.uid;
    } catch (error) {
      Fluttertoast.showToast(
          msg: ' Enter Corrent Email or Password ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }
}
