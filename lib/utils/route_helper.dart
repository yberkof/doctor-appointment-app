import 'package:flutter/material.dart';
import 'package:medicare/screens/doctor_home.dart';
import 'package:medicare/screens/nurse_home.dart';
import 'package:medicare/screens/parent_home.dart';

import '../models/app_model.dart';

class RouteHelper {
  static var shared = RouteHelper._();

  RouteHelper._();

  Widget getHomeByRole() {
    switch (AppModel.shared.currentUser.value?.role) {
      case '1':
        return ParentHome();
      case '4':
        return DoctorHome();
      case '3':
        return NurseHome();
      default:
        return ParentHome();
    }
  }
}
