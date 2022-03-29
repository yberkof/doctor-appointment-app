import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../screens/settings_screen.dart';

class HomeForNotImplementedRole extends StatelessWidget {
  const HomeForNotImplementedRole({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.black,
        child: Column(
          children: [
            Center(
                child: Container(
              color: Colors.deepOrange,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  S.current
                      .pleaseContactTheManagementToCompleteYourRegistration,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
            SettingsScreen()
          ],
        ),
      ),
    );
  }
}
