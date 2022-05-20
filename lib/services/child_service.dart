import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicare/models/app_model.dart';
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

  Future<List<Child>> getChildren(BuildContext context) async {
    try {
      var querySnapshot = await children.get();
      return querySnapshot.docs
          .where((element) =>
              element.get('parentId') ==
                  FirebaseAuth.instance.currentUser!.uid ||
              AppModel.shared.currentUser.value!.role == '3')
          .map<Child>((e) => Child.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      AlertHelper.showError(context, error.toString());
      return [];
    }
  }

  Future<void> updateChild(BuildContext context, Child child) async {
    return children
        .where('nationalId', isEqualTo: child.nationalId)
        .get()
        .then((value) {
      children.doc(value.docs[0].id).update(child.toJson());
      AlertHelper.hideProgressDialog(context);
    }).catchError((error) {
      AlertHelper.hideProgressDialog(context);
      AlertHelper.showError(context, error);
    });
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
