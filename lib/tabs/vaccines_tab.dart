import 'package:flutter/material.dart';
import 'package:medicare/models/vaccine_model.dart';
import 'package:medicare/services/vaccines_service.dart';

import '../styles/colors.dart';

class VaccinesTab extends StatefulWidget {
  const VaccinesTab({Key? key}) : super(key: key);

  @override
  _VaccinesTabState createState() => _VaccinesTabState();
}

class _VaccinesTabState extends State<VaccinesTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vaccine>>(
        future: VaccinesService.shared.getVaccines(context),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return Container(
                child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapShot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Vaccine vaccine = snapShot.data![index];
                // int hoursLeft = DateTime.now().difference(vaccine.time).inHours;
                // hoursLeft = hoursLeft < 0 ? -hoursLeft : 0;
                // double percent = hoursLeft / 48;

                return Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 30.0),
                      height: 130.0,
                      width: 15.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30.0),
                      padding: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 10.0),
                      height: 130.0,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                vaccine.vaccineName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.receipt,
                                    color: Theme.of(context).accentColor,
                                    size: 17.0,
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(
                                    vaccine.vaccineDesc,
                                    style: TextStyle(
                                      color: kTextColor,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ));
          }
          return Container(
            height: MediaQuery.of(context).size.height,
          );
        });
  }
}
