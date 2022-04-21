import 'package:flutter/material.dart';
import 'package:medicare/screens/Doctor_Home.dart';
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
      default:
        return ParentHome();
    }
  }
}
