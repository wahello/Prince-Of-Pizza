import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prince_of_pizza/Extra/global.dart';
import 'package:prince_of_pizza/Model/Item.dart';
import 'package:prince_of_pizza/administration/admin.dart';
import 'package:random_string/random_string.dart';

Firestore _fireStore = Firestore.instance;

class DataBase {
  static Stream<QuerySnapshot> getBasicInfo() {
    return _fireStore.collection("basicInfo").snapshots();
  }

  static setBasicInfo(content, String address, String line, String name,
      String timeing, String discounts, File logo) async {
    await _fireStore.collection("basicInfo").document("details").setData(
        {"address": address, "line": line, "name": name, "timeing": timeing});
    if (discounts != null && discounts != "" && discounts != " ") {
      discounts = discounts.replaceAll("\n", ",");
      await _fireStore
          .collection("basicInfo")
          .document("discounts")
          .setData({"details": discounts});
    }
    if (logo != null) {
      FirebaseStorage storage = FirebaseStorage(
          storageBucket: 'gs://princeofpizza-a144e.appspot.com/');
      String filePathCover =
          '${logo.path.split('/').last}' + DateTime.now().toString();
      StorageUploadTask uploadTask =
          storage.ref().child(filePathCover).putFile(logo);
      var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
      await _fireStore
          .collection("basicInfo")
          .document("logo")
          .setData({"logo": dowurl.toString()});
      Navigator.pushReplacement(
        content,
        MaterialPageRoute(
          builder: (context) => AdminPanal(),
        ),
      );
    } else {
      Navigator.pushReplacement(
          content, MaterialPageRoute(builder: (context) => AdminPanal()));
    }
  }

  static Stream<QuerySnapshot> getCatagories() {
    return _fireStore.collection("categories").snapshots();
  }

  static setCatagories(String name) async {
    await _fireStore
        .collection("categories")
        .document(name)
        .setData({"null": "null"});
  }

  static Stream<QuerySnapshot> getPizza(String str) {
    return _fireStore
        .collection("categories")
        .document(str)
        .collection("List of Items")
        .snapshots();
  }

  static setPizza(
      String str1,
      String str2,
      Map<String, dynamic> data,
      Map<String, dynamic> data2,
      Map<String, Map<String, Map<String, String>>> data3) async {
    data3.forEach((k, v) async {
      String l = v.keys.toList()[0][0];
      await _fireStore
          .collection("categories")
          .document(str1)
          .collection("List of Items")
          .document(str2)
          .collection("details")
          .document(k)
          .setData({"cat": l});

      if (l == "3")
        v.forEach((key, val) async {
          await _fireStore
              .collection("categories")
              .document(str1)
              .collection("List of Items")
              .document(str2)
              .collection("details")
              .document(k)
              .collection("catagories")
              .document(val["name"])
              .setData({
            "0": val["0"] + "\$",
            "1": val["1"] + "\$",
            "2": val["2"] + "\$"
          });
        });
      else
        v.forEach((key, val) async {
          await _fireStore
              .collection("categories")
              .document(str1)
              .collection("List of Items")
              .document(str2)
              .collection("details")
              .document(k)
              .collection("catagories")
              .document(val["name"])
              .setData({"0": val["0"] + "\$"});
        });
    });

    await _fireStore
        .collection("categories")
        .document(str1)
        .collection("List of Items")
        .document(str2)
        .setData(data);

    await _fireStore
        .collection("categories")
        .document(str1)
        .collection("List of Items")
        .document(str2)
        .collection("details")
        .document("Type")
        .setData(data2);
  }

  static Stream<DocumentSnapshot> getTypes(String cat, String subCat) {
    return _fireStore
        .collection("categories")
        .document(cat)
        .collection("List of Items")
        .document(subCat)
        .collection("details")
        .document("Type")
        .snapshots();
  }

  static Stream<QuerySnapshot> getAddOns(String str, String str2) {
    return _fireStore
        .collection("categories")
        .document(str)
        .collection("List of Items")
        .document(str2)
        .collection("details")
        .snapshots();
  }

  static Stream<QuerySnapshot> getAddOnsDetails(
      String str, String str2, String str3) {
    return _fireStore
        .collection("categories")
        .document(str)
        .collection("List of Items")
        .document(str2)
        .collection("details")
        .document(str3)
        .collection("catagories")
        .snapshots();
  }

  static Stream<QuerySnapshot> getExtraIteams() {
    return _fireStore.collection("extraItems").snapshots();
  }

  static setExtraIteams(name, price, tag) async {
    await _fireStore
        .collection("extraItems")
        .document(name)
        .setData({"price": "\$" + price, "tag": tag});
  }

  static setUserDetails(String id, Map<String, dynamic> data) async {
    return await _fireStore.collection("User").document(id).setData(data);
  }

  static Stream<DocumentSnapshot> getUserDetails(String id) {
    return _fireStore.collection("User").document(id).snapshots();
  }

  static placeOrderDetails() async {
    String oId = DateTime.now().toString() + randomAlpha(5);
    Map<String, Object> data = Map<String, Object>();
    data["firebaseId"] = MyGlobals.myOrder.firebaseId;
    data["instructions"] = MyGlobals.myOrder.instructions;
    data["paymentMethod"] = MyGlobals.myOrder.paymentMethod;
    data["date"] = DateTime.now().toString();
    data["status"] = MyGlobals.myOrder.status;
    data["totalAmount"] = MyGlobals.myOrder.totalAmount;
    data["extrasList"] = MyGlobals.extrasList;
    data["iteamsList"] = Item.convert(MyGlobals.iteamsList);
    return await _fireStore.collection("Orders").document(oId).setData(data);
  }

  static Stream<QuerySnapshot> getOrdersList() {
    return _fireStore.collection("Orders").limit(30).snapshots();
  }

}
