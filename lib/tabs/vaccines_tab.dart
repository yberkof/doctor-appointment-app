import 'package:flutter/material.dart';
import 'package:medicare/models/vaccine_model.dart';
import 'package:medicare/screens/add_vaccine_screen.dart';
import 'package:medicare/services/vaccines_service.dart';

import '../styles/colors.dart';
import 'HomeTab.dart';

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
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.teal,
                onPressed: () {
                  showBottomSheet(
                      context: context, builder: (c) => AddVaccineScreen());
                },
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      UserIntro(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Vaccines',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapShot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Vaccine vaccine = snapShot.data![index];
                          // int hoursLeft = DateTime.now().difference(vaccine.time).inHours;
                          // hoursLeft = hoursLeft < 0 ? -hoursLeft : 0;
                          // double percent = hoursLeft / 48;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: <Widget>[
                                Container(
                                  height: 200.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.90,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      bottomLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(12.0),
                                      bottomRight: Radius.circular(12.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      10.0, 20.0, 20.0, 10.0),
                                  height: 200.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12.0),
                                      bottomRight: Radius.circular(12.0),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        vaccine.vaccineName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      SizedBox(height: 15.0),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.vaccines_sharp,
                                            color:
                                                Theme.of(context).accentColor,
                                            size: 17.0,
                                          ),
                                          SizedBox(width: 10.0),
                                          Expanded(
                                            child: Text(
                                              vaccine.vaccineDesc,
                                              maxLines: 3,
                                              style: TextStyle(
                                                color: kTextColor,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: const [
                                            Flexible(
                                                flex: 1, child: Text('Years')),
                                            Flexible(
                                                flex: 1, child: Text("Months")),
                                            Flexible(
                                                flex: 1, child: Text('Days')),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Flexible(
                                                flex: 1,
                                                child: Text(vaccine
                                                    .vaccineTime.years
                                                    .toString())),
                                            Flexible(
                                                flex: 1,
                                                child: Text(vaccine
                                                    .vaccineTime.months
                                                    .toString())),
                                            Flexible(
                                                flex: 1,
                                                child: Text(vaccine
                                                    .vaccineTime.days
                                                    .toString())),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container(
            height: MediaQuery.of(context).size.height,
          );
        });
  }
}
