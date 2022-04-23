import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../generated/l10n.dart';
import '../models/app_model.dart';
import '../models/user.dart' as user;
import '../screens/login_page.dart';
import '../utils/alert_helper.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(
    this._firebaseAuth,
  );

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<UserCredential?> signIn(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      AlertHelper.hideProgressDialog(context);
      AlertHelper.showError(context, e.message ?? S.current.failed);
      return null;
    }
  }

  Future<String> logout(BuildContext context) async {
    try {
      AlertHelper.showProgressDialog(context);
      await _firebaseAuth.signOut();
      AppModel.shared.currentUser = Rx<user.User?>(null);
      AlertHelper.hideProgressDialog(context);
      Navigator.popUntil(context, (route) => Navigator.of(context).canPop());
      Navigator.push(context, MaterialPageRoute(builder: (c) => LoginPage()));
      return "Signed out";
    } on FirebaseAuthException catch (e) {
      return "Error Signout : " + e.message.toString();
    }
  }

  Future<UserCredential?> signUp(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      AlertHelper.hideProgressDialog(context);
      AlertHelper.showError(context, e.message.toString());
      return null;
    }
  }
}
