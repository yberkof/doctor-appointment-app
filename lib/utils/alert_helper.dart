import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class AlertHelper {
  static void showError(BuildContext context, String err) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        confirmBtnText: S.of(context).retry,
        text: err,
        title: S.of(context).failed,
        backgroundColor: Colors.blue.shade200,
        confirmBtnColor: Theme.of(context).primaryColor);
  }

  static void showProgressDialog(BuildContext context) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.loading,
        barrierDismissible: false);
  }

  static void hideProgressDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
