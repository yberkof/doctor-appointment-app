import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/appointment_model.dart';
import '../utils/alert_helper.dart';

class AppointmentsService {
  static var shared = AppointmentsService();
  CollectionReference appointments =
      FirebaseFirestore.instance.collection('Appointments');

  Future<void> addAppointment(BuildContext context, Appointment appointment) {
    return appointments
        .add(appointment.toJson())
        .then((value) => print("Appointment Added"))
        .catchError((error) {
      AlertHelper.hideProgressDialog(context);
      AlertHelper.showError(context, error);
    });
  }

  Future<List<Appointment>> getAppointments(BuildContext context) async {
    try {
      var querySnapshot = await appointments.get();
      return querySnapshot.docs
          .map<Appointment>(
              (e) => Appointment.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      AlertHelper.showError(context, error.toString());
      return [];
    }
  }

// void editUser(BuildContext context, Appointment? currentUser) async {
//   var querySnapshot =
//   await Appointments.where('uid', isEqualTo: currentUser!.uid).get();
//
//   Appointments
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
