import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/generated/l10n.dart';
import 'package:ui/models/app_model.dart';
import 'package:ui/screens/login_page.dart';
import 'package:ui/screens/upload_image_screen.dart';
import 'package:ui/services/auth_service.dart';
import 'package:ui/utils/alert_helper.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12.0),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildCircleAvatar(context),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleAvatar(BuildContext context) {
    return InkWell(
      onTap: () {
        changePhoto(context);
      },
      child: CircleAvatar(
        radius: 100.0,
        backgroundImage: AppModel.shared.currentUser.value.image != null
            ? CachedNetworkImageProvider(
                AppModel.shared.currentUser.value.image)
            : AssetImage("assets/images/user.png"),
      ),
    );
  }

  void changePhoto(BuildContext context) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => UploadImageScreen()));
    setState(() {});
  }

  Padding _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: SizedBox(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35,
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  AuthenticationService(FirebaseAuth.instance).logout(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    S.of(context).logout,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Image.asset(
              'assets/images/logout.png',
              width: 50,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
