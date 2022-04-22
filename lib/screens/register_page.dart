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
      "role": '1'
    },
    {
      "name": "Parent",
      "desc": "Add Children, Check vaccination status",
      "role": '2'
    },
    {
      "name": "Nurse",
      "desc": "Organize appointments and patients",
      "role": '3'
    },
    {"name": "Doctor", "desc": "add and edit scheduled vaccines", "role": '4'},
  ];

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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),

                  // dropdown below..
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _currentRole,
                    onChanged: (String? newValue) =>
                        setState(() => _currentRole = newValue),
                    items: _roles
                        .map<DropdownMenuItem<String>>((var value) =>
                            DropdownMenuItem<String>(
                              value: value['role'],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value['name'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  Text(
                                    value['desc'],
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),

                    // add extra sugar..
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 42,
                    underline: SizedBox(),
                  ),
                ),
                SizedBox(height: 12),
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
                                    role: _roleDropdownEditingController
                                        .value!['role']
                                        .toString()))
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
