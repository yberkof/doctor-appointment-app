import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:ui/constants.dart';
import 'package:ui/models/app_model.dart';
import 'package:ui/models/homework.dart';
import 'package:ui/services/homework_service.dart';

class RecentHomeworks extends StatefulWidget {
  @override
  _RecentHomeworksState createState() => _RecentHomeworksState();
}

class _RecentHomeworksState extends State<RecentHomeworks> {
  DateFormat dateFormat = DateFormat("hh:mm a");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Homework>>(
        future: HomeworksService.shared.getHomeworks(context),
        builder: (context, snapShot) {
          if (snapShot.hasData)
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapShot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Homework homework = snapShot.data[index];
                return Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 30.0),
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 10.0),
                      height: 100.0,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: kCardColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                homework.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    AntDesign.clockcircle,
                                    color: Theme.of(context).accentColor,
                                    size: 17.0,
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "${DateTime.now().weekday == homework.time.weekday ? "Today" : DateFormat.EEEE().format(homework.time)}, ${dateFormat.format(homework.time)}",
                                    style: TextStyle(
                                      color: kTextColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          _todoButton(homework),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          return Container(
            height: MediaQuery.of(context).size.height,
          );
        });
  }

  _todoButton(Homework homework) {
    var contains =
        homework.doneBy.contains(AppModel.shared.currentUser.value.uid);
    return RaisedButton(
      onPressed: () {
        setState(() {});
      },
      shape: CircleBorder(
        side: BorderSide(color: Theme.of(context).accentColor),
      ),
      color: contains ? Theme.of(context).accentColor : Colors.transparent,
      child: contains ? Icon(Icons.check, color: Colors.white) : null,
    );
  }
}
