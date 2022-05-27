import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicare/models/user.dart' as user;

import '../generated/l10n.dart';
import '../services/auth_service.dart';
import '../services/users_service.dart';
import '../utils/alert_helper.dart';
import '../widgets/app_textfield.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;
  var _roleDropdownEditingController =
      DropdownEditingController<Map<String, dynamic>>();

  var _currentRole;
  final List<Map<String, dynamic>> _roles = [
    {
      "name": "Admin",
      "desc": "Having full access rights to all users",
      "role": '2'
    },
    {
      "name": "Parent",
      "desc": "Add Children, Check vaccination status",
      "role": '1'
    },
    {
      "name": "Nurse",
      "desc": "Organize appointments and patients",
      "role": '3'
    },
    {"name": "Doctor", "desc": "add and edit scheduled vaccines", "role": '4'},
  ];
  var list = ['Amman', 'Aqaba'];

  late String _selectedCity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _roleDropdownEditingController.value = _roles[0];
    _currentRole = _roles[1]['role'];
    _selectedCity = list[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: ListView(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        child: Image.asset(
                          'assets/logo_video.gif',
                          width: 250,
                          height: 250,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        size: 36,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Text(
                  S.of(context).signUp,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                SizedBox(height: 24),
                AppTextField(
                  controller: _emailController!,
                  hint: S.of(context).emailId,
                  icon: Icons.email,
                ),
                SizedBox(height: 12),
                AppTextField(
                    controller: _passwordController!,
                    hint: S.of(context).password,
                    icon: Icons.lock,
                    isObscureText: true),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                      icon: Icon(
                        Icons.location_city,
                        color: Colors.black54,
                      ),
                      isExpanded: true,
                      value: _selectedCity,
                      elevation: 15,
                      items: list
                          .map((e) => DropdownMenuItem<String>(
                              child: Text(e), value: e))
                          .toList(),
                      onChanged: (e) {
                        setState(() {
                          _selectedCity = e!;
                        });
                      }),
                ),
                AppTextField(
                  controller: _firstNameController!,
                  hint: S.of(context).firstName,
                  icon: Icons.person,
                ),
                SizedBox(height: 12),
                AppTextField(
                  controller: _lastNameController!,
                  hint: S.of(context).lastName,
                  icon: Icons.person,
                ),
                SizedBox(height: 12),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(16),
                  child: Text(
                    S.of(context).register,
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
                        .signUp(context, _emailController!.text,
                            _passwordController!.text)
                        .then((value) {
                      if (value != null) {
                        UsersService.shared
                            .addUser(
                                context,
                                user.User(
                                    email: _emailController!.text,
                                    firstName: _firstNameController!.text,
                                    lastName: _lastNameController!.text,
                                    uid: value.user!.uid,
                                    city: _selectedCity,
                                    role: '1'))
                            .then((value) {
                          AlertHelper.hideProgressDialog(context);
                          Navigator.of(context).pop();
                        });
                      }
                    });
                  },
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
