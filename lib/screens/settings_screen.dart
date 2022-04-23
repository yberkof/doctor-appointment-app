import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicare/screens/upload_image_screen.dart';

import '../generated/l10n.dart';
import '../models/app_model.dart';
import '../services/auth_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
    String? image2 = AppModel.shared.currentUser.value!.image;
    return InkWell(
      onTap: () {
        changePhoto(context);
      },
      child: CircleAvatar(
        radius: 100.0,
        backgroundImage: image2 != null
            ? CachedNetworkImageProvider(image2)
            : Image.asset("assets/user.png").image,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 35,
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {
              AuthenticationService(FirebaseAuth.instance).logout(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.logout_sharp,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    S.of(context).logout,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
