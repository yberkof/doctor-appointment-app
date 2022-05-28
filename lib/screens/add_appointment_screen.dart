import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicare/configuration/app_constant.dart';
import 'package:medicare/models/user.dart';
import 'package:medicare/models/vaccine_model.dart';
import 'package:medicare/services/vaccines_service.dart';
import 'package:medicare/tabs/ScheduleTab.dart';

import '../models/appointment_model.dart';
import '../services/appointments_service.dart';
import '../services/users_service.dart';
import '../utils/alert_helper.dart';

class AddAppointmentScreen extends StatefulWidget {
  const AddAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AddAppointmentScreen> createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  DateTime selectedTime = DateTime.now();

  late String _doctorName = "";
  late String _vaccineName = "";

  List<User>? _doctors;

  List<Vaccine>? _vaccines;

  bool _isSecondDose = false;

  String _selectedRegion = JORDAN_REGIONS[0]["value"]!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buildDoctors(context);
    buildVaccines(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
          child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: Text('Add Appointment'),
              ),
              _doctors != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Doctor Name',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w700),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              isExpanded: true,

                              value: _doctorName,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _doctorName = newValue!;
                                });
                              },
                              items: _doctors!
                                  .map<DropdownMenuItem<String>>(
                                      (var value) => DropdownMenuItem<String>(
                                            value: value.uid,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.firstName +
                                                      ' ' +
                                                      value.lastName,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor),
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
                        ],
                      ),
                    )
                  : CircularProgressIndicator(),
              _vaccines != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vaccine Name',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w700),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _vaccineName,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _vaccineName = newValue!;
                                });
                              },
                              items: _vaccines!
                                  .map<DropdownMenuItem<String>>(
                                      (var value) => DropdownMenuItem<String>(
                                            value: value.vaccineName,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.vaccineName,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor),
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
                        ],
                      ),
                    )
                  : CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Region Name',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedRegion,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedRegion = newValue!;
                          });
                        },
                        items: JORDAN_REGIONS
                            .map<DropdownMenuItem<String>>(
                                (var value) => DropdownMenuItem<String>(
                                      value: value["value"],
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            value["name"]!,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .primaryColor),
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
                  ],
                ),
              ),
              if (_vaccines != null &&
                  _vaccines!
                      .where((element) =>
                          element.vaccineName == _vaccineName &&
                          element.hasSecondDose)
                      .isNotEmpty)
                Row(
                  children: [
                    Checkbox(
                      value: _isSecondDose,
                      onChanged: (v) {
                        setState(() {
                          _isSecondDose = v!;
                        });
                      },
                    ),
                    Text('Is Second Dose?')
                  ],
                ),
              DateTimePicker(
                type: DateTimePickerType.dateTime,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: "Hour",
                selectableDayPredicate: (date) {
                  // Disable weekend days to select from the calendar

                  return true;
                },
                onChanged: (val) {
                  setState(() {
                    selectedTime = DateTime.parse(val);
                  });
                  if (kDebugMode) {
                    print(val);
                  }
                },
                validator: (val) {
                  if (kDebugMode) {
                    print(val);
                  }
                  return null;
                },
                onSaved: (val) => print(val),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    AlertHelper.showProgressDialog(context);
                    var user = _doctors!
                        .where((element) => _doctorName == element.uid)
                        .first;
                    AppointmentsService.shared
                        .addAppointment(
                            context,
                            Appointment(
                                vaccineName: _vaccineName,
                                reservedTime: DateFormat('dd/MM/yyyy')
                                    .format(selectedTime),
                                status: FilterStatus.Upcoming.toString(),
                                doctorName:
                                    user.firstName + " " + user.lastName,
                                reservedDate:
                                    DateFormat('HH:MM').format(selectedTime),
                                isSecondDose: _isSecondDose,
                                region: _selectedRegion))
                        .then((value) {
                      AlertHelper.hideProgressDialog(context);
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void buildVaccines(BuildContext context) async {
    var vaccines = await VaccinesService.shared.getVaccines(context);

    setState(() {
      _vaccines = vaccines;
      _vaccineName = vaccines[0].vaccineName;
    });
  }

  void buildDoctors(BuildContext context) async {
    var doctors = await UsersService.shared.getDoctors(context);

    setState(() {
      _doctors = doctors;

      _doctorName = _doctors![0].uid;
    });
  }
}
