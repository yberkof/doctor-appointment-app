import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import '../utils/alert_helper.dart';

class UsersService {
  static var shared = UsersService();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(BuildContext context, User user) {
    return users
        .add(user.toMap())
        .then((value) => print("User Added"))
        .catchError((error) {
      AlertHelper.hideProgressDialog(context);
      AlertHelper.showError(context, error);
    });
  }

  void editUser(BuildContext context, User? currentUser) async {
    var querySnapshot =
        await users.where('uid', isEqualTo: currentUser!.uid).get();

    users
        .doc(querySnapshot.docs[0].id)
        .update(currentUser.toMap())
        .then((value) {
      AlertHelper.hideProgressDialog(context);
      print("User edited");
      Get.back();
    }).catchError((error) {
      AlertHelper.hideProgressDialog(context);
      AlertHelper.showError(context, error);
      Get.back();
    });
  }

  Future<List<User>> getDoctors(BuildContext context) async {
    var querySnapshot = await users.where('role', isEqualTo: '2').get();
    try {
      return querySnapshot.docs
          .map<User>((e) => User.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      AlertHelper.showError(context, error.toString());
      return [];
    }
  }
}
