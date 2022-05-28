import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:medicare/generated/l10n.dart';
import 'package:medicare/migrations/child_migration.dart';
import 'package:medicare/screens/welcome_screen.dart';
import 'package:medicare/styles/colors.dart';
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
  // UserMigration().migrateUserCity();
  // VaccineMigration().migrateVaccineSecondDose();
  // AppointmentMigration().migrateAppointmentSecondDose();
  // AppointmentMigration().migrateAppointmentRegions();
  ChildMigration().migrateChildrenTakenVaccines();
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
      locale: Locale('en'),
      theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
          accentColor: Colors.teal,
          buttonColor: Colors.teal,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            primary: Colors.teal,
          )),
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.teal,
              backgroundColor: Colors.teal,
              primaryColorDark: Colors.teal),
          // Define the default brightness and colors.
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(MyColors.primary),
          )
          // Define the default font family.

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          // textTheme: const TextTheme(
          //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          // ),
          ),
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
