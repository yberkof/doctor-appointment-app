import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicare/models/app_model.dart';
import 'package:medicare/models/appointment_model.dart';
import 'package:medicare/screens/add_appointment_screen.dart';
import 'package:medicare/services/appointments_service.dart';
import 'package:medicare/styles/colors.dart';
import 'package:medicare/styles/styles.dart';
import 'package:medicare/tabs/HomeTab.dart';
import 'package:medicare/utils/alert_helper.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key}) : super(key: key);

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

enum FilterStatus { Upcoming, Complete }

class _ScheduleTabState extends State<ScheduleTab> {
  FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AppModel.shared.currentUser.value!.role == '3'
          ? FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Colors.teal,
              onPressed: () {
                showBottomSheet(
                    context: context, builder: (c) => AddAppointmentScreen());
              },
            )
          : Container(),
      body: FutureBuilder<List<Appointment>>(
          future: AppointmentsService().getAppointments(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (status == FilterStatus.Upcoming) {
                snapshot.data!.removeWhere((element) => DateFormat(
                        "dd/MM/yyyy HH:mm")
                    .parse(element.reservedTime + ' ' + element.reservedDate)
                    .isBefore(DateTime.now()));
              } else if (status == FilterStatus.Complete) {
                snapshot.data!.removeWhere((element) => DateFormat(
                        "dd/MM/yyyy HH:mm")
                    .parse(element.reservedTime + ' ' + element.reservedDate)
                    .isAfter(DateTime.now()));
              }
              return Padding(
                padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
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
                      'Schedule',
                      textAlign: TextAlign.center,
                      style: kTitleStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(MyColors.bg),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (FilterStatus filterStatus
                                  in FilterStatus.values)
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (filterStatus ==
                                          FilterStatus.Upcoming) {
                                        status = FilterStatus.Upcoming;
                                        _alignment = Alignment.centerLeft;
                                      } else if (filterStatus ==
                                          FilterStatus.Complete) {
                                        status = FilterStatus.Complete;
                                        _alignment = Alignment.centerRight;
                                      }
                                      setState(() {});
                                    },
                                    child: Center(
                                      child: Text(
                                        filterStatus.name,
                                        style: kFilterStyle,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        AnimatedAlign(
                          duration: Duration(milliseconds: 200),
                          alignment: _alignment,
                          child: Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(MyColors.primary),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                status.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Appointment appointment = snapshot.data![index];
                          bool isLastElement =
                              snapshot.data!.length + 1 == index;
                          return Card(
                            margin: !isLastElement
                                ? EdgeInsets.only(bottom: 20)
                                : EdgeInsets.zero,
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            Text(
                                              'Vaccine Name: ' +
                                                  appointment.vaccineName,
                                              style: TextStyle(
                                                color: Color(MyColors.header01),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            if (appointment.isSecondDose) ...[
                                              Icon(
                                                Icons.info_outline,
                                                color: Colors.blue,
                                                size: 15,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Second Dose',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ]),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Doctor Name: ' +
                                                appointment.doctorName,
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Region Name: ' +
                                                appointment.region,
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  DateTimeCard(
                                    appointment: appointment,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  AppModel.shared.currentUser.value!.role ==
                                              '3' &&
                                          DateFormat("dd/MM/yyyy HH:mm")
                                              .parse(appointment.reservedTime +
                                                  ' ' +
                                                  appointment.reservedDate)
                                              .isAfter(DateTime.now())
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: OutlinedButton(
                                                child: Text('Cancel'),
                                                onPressed: () {
                                                  AlertHelper
                                                      .showProgressDialog(
                                                          context);
                                                  AppointmentsService.shared
                                                      .deleteAppointment(
                                                          appointment, context)
                                                      .then((value) {
                                                    setState(() {});
                                                  });
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                          ],
                                  )
                                      : Container()
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  final Appointment appointment;

  const DateTimeCard({Key? key, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(MyColors.primary),
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                appointment.reservedDate,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_alarm,
                color: Color(MyColors.primary),
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                appointment.reservedTime,
                style: TextStyle(
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
