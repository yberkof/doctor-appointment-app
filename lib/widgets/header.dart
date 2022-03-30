import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

import '../generated/l10n.dart';
import '../models/app_model.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<AppModel>(
      init: AppModel.shared,
      builder: (appModel) {
        if (appModel.currentUser.value == null) return Container();
        return Padding(
            padding: EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 8.0),
            child: Column(
              children: [
                _buildFirstRow(context, appModel),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).name +
                            ' ' +
                            appModel.currentUser.value!.firstName +
                            ' ' +
                            appModel.currentUser.value!.lastName,
                        style: _getTextStyle(fontSize: 20),
                      ),
                      Text(
                        S.of(context).email +
                            ' ' +
                            appModel.currentUser.value!.email,
                        style: _getTextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  Row _buildFirstRow(BuildContext context, AppModel appModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        getHeadAsset()!,
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 30,
          child: Marquee(
            text: appModel.currentUser.value!.schoolName.length < 20
                ? appModel.currentUser.value!.schoolName + " " * 35
                : appModel.currentUser.value!.schoolName,
            style: _getTextStyle(),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 20.0,
            velocity: 100.0,
            pauseAfterRound: Duration(microseconds: 100),
            startPadding: 10.0,
            accelerationDuration: Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
        Obx(
          () {
            var image2 = appModel.currentUser.value!.image;
            return CircleAvatar(
              radius: 25.0,
              backgroundImage: image2 != null
                  ? CachedNetworkImageProvider(image2!)
                  : Image.asset("assets/images/user.png").image,
            );
          },
        ),
      ],
    );
  }

  Widget? getHeadAsset() {
    switch (AppModel.shared.currentUser.value!.role) {
      case '4':
        return SvgPicture.asset(
          'assets/icons/grad_cap.png',
          height: 70.0,
        );
      case '3':
        return Image.asset(
          'assets/icons/teacher_head.png',
          height: 70.0,
        );
    }
  }

  TextStyle _getTextStyle({double fontSize = 25}) {
    return TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
  }
}
