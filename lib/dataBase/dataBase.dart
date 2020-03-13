import 'package:cloud_firestore/cloud_firestore.dart';

Firestore _fireStore = Firestore.instance;

class DataBase {
  static Stream<QuerySnapshot> getBasicInfo() {
    return _fireStore.collection("basicInfo").snapshots();
  }

  static Stream<QuerySnapshot> getCatagories() {
    return _fireStore.collection("categories").snapshots();
  }

  static Stream<QuerySnapshot> getSubCatagories(String str) {
    return _fireStore
        .collection("categories")
        .document(str)
        .collection("List of Items")
        .snapshots();
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

  static Stream<QuerySnapshot> getAddOnsDetails(String str, String str2, String str3) {
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

  static setUserDetails(String id, Map<String, dynamic> data) async {
    return await _fireStore.collection("User").document(id).setData(data);
  }

  static Stream<DocumentSnapshot> getUserDetails(String id) {
    return _fireStore.collection("User").document(id).snapshots();
  }
}
