import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicare/models/child_model.dart';

import '../utils/alert_helper.dart';

class ChildService {
  static var shared = ChildService();
  CollectionReference children =
      FirebaseFirestore.instance.collection('children');

  Future<void> addChild(BuildContext context, Child child) {
    return children
        .add(child.toJson())
        .then((value) => print("Vaccine Added"))
        .catchError((error) {
      AlertHelper.hideProgressDialog(context);
      AlertHelper.showError(context, error);
    });
  }

  Future<List<Child>> getChild(BuildContext context) async {
    try {
      var querySnapshot = await children.get();
      return querySnapshot.docs
          .map<Child>((e) => Child.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      AlertHelper.showError(context, error.toString());
      return [];
    }
  }

// void editUser(BuildContext context, Vaccine? currentUser) async {
//   var querySnapshot =
//   await Child.where('uid', isEqualTo: currentUser!.uid).get();
//
//   Child
//       .doc(querySnapshot.docs[0].id)
//       .update(currentUser.toMap())
//       .then((value) {
//     AlertHelper.hideProgressDialog(context);
//     print("User edited");
//     Get.back();
//   }).catchError((error) {
//     AlertHelper.hideProgressDialog(context);
//     AlertHelper.showError(context, error);
//     Get.back();
//   });
// }
}