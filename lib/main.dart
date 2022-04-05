import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:medicare/generated/l10n.dart';
import 'package:medicare/screens/welcome_screen.dart';
import 'package:medicare/utils/app_model_helper.dart';
import 'package:medicare/utils/route_helper.dart';
import 'package:medicare/utils/textscale.dart';

import 'models/app_model.dart';

Future<void> main() async {
  S.load(Locale('en'));
  Get.changeTheme(
      ThemeData(primaryColor: Colors.teal, accentColor: Colors.tealAccent));
  Get.updateLocale(Locale('en'));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AppModel.shared);
  if (FirebaseAuth.instance.currentUser != null) {
    AppModelHelper.shared.loadCurrentUser(() {
      runApp(MyApp());
    });
  } else {
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: fixTextScale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: _getRoute(),
    );
  }

  Widget _getRoute() {
    return FirebaseAuth.instance.currentUser != null
        ? RouteHelper.shared.getHomeByRole()
        : WelcomeScreen();
  }
}
