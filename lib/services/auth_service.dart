import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui/models/app_model.dart';
import 'package:ui/screens/login_page.dart';
import 'package:ui/utils/alert_helper.dart';
import 'package:ui/utils/app_model_helper.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(
    this._firebaseAuth,
  );

  Stream<User> get authStateChange => _firebaseAuth.authStateChanges();

  Future<UserCredential> signIn(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      AlertHelper.hideProgressDialog(context);
      AlertHelper.showError(context, e.message);
      return null;
    }
  }

  Future<String> logout(BuildContext context) async {
    try {
      AlertHelper.showProgressDialog(context);
      await _firebaseAuth.signOut();
      AppModel.shared.currentUser = null;
      AlertHelper.hideProgressDialog(context);
      Navigator.popUntil(context, (route) => Navigator.of(context).canPop());
      Navigator.push(context, MaterialPageRoute(builder: (c) => LoginPage()));
      return "Signed out";
    } on FirebaseAuthException catch (e) {
      return "Error Signout : " + e.message;
    }
  }

  Future<UserCredential> signUp(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      AlertHelper.hideProgressDialog(context);
      AlertHelper.showError(context, e.message);
      return null;
    }
  }
}
