import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medicare/generated/l10n.dart';
import 'package:medicare/screens/register_page.dart';
import 'package:medicare/services/auth_service.dart';
import 'package:medicare/utils/alert_helper.dart';
import 'package:medicare/utils/app_model_helper.dart';
import 'package:medicare/utils/route_helper.dart';
import 'package:medicare/widgets/app_textfield.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TapGestureRecognizer? registerOnTap;

  TextEditingController? _passwordController;

  TextEditingController? _emailController;

  @override
  void initState() {
    registerOnTap = TapGestureRecognizer();
    registerOnTap!.onTap = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RegisterPage(),
        ),
      );
    };
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: ListView(
            children: [
              SizedBox(
                child: Image.asset(
                  'assets/logo_video.gif',
                  width: 250,
                  height: 250,
                ),
              ),
              Text(
                S.of(context).login,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 32,
                ),
              ),
              SizedBox(height: 12),
              AppTextField(
                hint: S.of(context).emailId,
                icon: Icons.email,
                controller: _emailController!,
              ),
              SizedBox(height: 12),
              AppTextField(
                hint: S.of(context).password,
                icon: Icons.lock,
                isObscureText: true,
                helpContent: Text(
                  S.of(context).forgot,
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).primaryColor),
                ),
                controller: _passwordController!,
                helpOnTap: () {},
              ),
              SizedBox(height: 12),
              FlatButton(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(16),
                child: Text(
                  S.current.login,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                onPressed: () {
                  AlertHelper.showProgressDialog(context);
                  AuthenticationService(FirebaseAuth.instance)
                      .signIn(context, _emailController!.text,
                          _passwordController!.text)
                      .then((value) {
                    if (value != null) {
                      AppModelHelper.shared.loadCurrentUser(() {
                        AlertHelper.hideProgressDialog(context);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (c) =>
                                RouteHelper.shared.getHomeByRole()));
                      });
                    }
                  });
                },
              ),
              SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  text: S.current.registerNewAccount,
                  children: [
                    TextSpan(
                      text: S.of(context).register,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: registerOnTap,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
