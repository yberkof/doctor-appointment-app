import 'package:flutter/material.dart';

import '../models/app_model.dart';

class RouteHelper {
  static var shared = RouteHelper._();

  RouteHelper._();

  Widget getHomeByRole() {
    switch (AppModel.shared.currentUser.value.role) {
      case '3':
        return TeacherBottomNavigation();
      case '4':
        return StudentBottomNavigation();
      default:
        return HomeForNotImplementedRole();
    }
  }
}
