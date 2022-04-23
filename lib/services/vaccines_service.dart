import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/vaccine_model.dart';
import '../utils/alert_helper.dart';

class VaccinesService {
  static var shared = VaccinesService();
  CollectionReference vaccines =
      FirebaseFirestore.instance.collection('vaccines');

  Future<void> addVaccine(BuildContext context, Vaccine vaccine) {
    return vaccines
        .add(vaccine.toJson())
        .then((value) => print("Vaccine Added"))
        .catchError((error) {
      AlertHelper.hideProgressDialog(context);
      AlertHelper.showError(context, error);
    });
  }

  Future<List<Vaccine>> getVaccines(BuildContext context) async {
    try {
      var querySnapshot = await vaccines.get();
      return querySnapshot.docs
          .map<Vaccine>(
              (e) => Vaccine.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      AlertHelper.showError(context, error.toString());
      return [];
    }
  }

// void editUser(BuildContext context, Vaccine? currentUser) async {
//   var querySnapshot =
//   await Vaccines.where('uid', isEqualTo: currentUser!.uid).get();
//
//   Vaccines
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
