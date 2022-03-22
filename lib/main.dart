import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/generated/l10n.dart';
import 'package:medicare/routes/router.dart';
import 'package:medicare/utils/textscale.dart';

void main() {
  S.load(Locale('en'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: fixTextScale,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
    );
  }
}
