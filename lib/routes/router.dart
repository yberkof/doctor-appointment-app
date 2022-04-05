import 'package:flutter/material.dart';
import 'package:medicare/screens/doctor_detail.dart';
import 'package:medicare/screens/home.dart';
import 'package:medicare/screens/welcome_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => WelcomeScreen(),
  '/detail': (context) => WelcomeScreen(),
};
