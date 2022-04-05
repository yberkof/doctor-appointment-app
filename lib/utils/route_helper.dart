import 'package:flutter/material.dart';
import 'package:medicare/screens/home.dart';

import '../models/app_model.dart';

class RouteHelper {
  static var shared = RouteHelper._();

  RouteHelper._();

  Widget getHomeByRole() {
    switch (AppModel.shared.currentUser.value?.role) {
      case '1':
        return Home();
      // case '4':
      //   return StudentBottomNavigation();
      default:
        return Home();
    }
  }
}
