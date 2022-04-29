import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicare/tabs/ScheduleTab.dart';

import '../models/appointment_model.dart';
import '../services/appointments_service.dart';
import '../utils/alert_helper.dart';
import '../widgets/app_textfield.dart';

class AddAppointmentScreen extends StatefulWidget {
  const AddAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AddAppointmentScreen> createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  late TextEditingController _doctorNameController;
  late TextEditingController _vaccineNameController;

  DateTime selectedTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _doctorNameController = TextEditingController();
    _vaccineNameController = TextEditingController();
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
              AppTextField(
                controller: _doctorNameController,
                hint: 'Doctor Name',
                icon: Icons.drive_file_rename_outline,
              ),
              AppTextField(
                controller: _vaccineNameController,
                hint: 'Vaccine Name',
                icon: Icons.vaccines_sharp,
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
                  if (date.weekday == 6 || date.weekday == 7) {
                    return false;
                  }

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
                    AppointmentsService.shared
                        .addAppointment(
                            context,
                            Appointment(
                                vaccineName: _vaccineNameController.text,
                                reservedTime: DateFormat('dd/MM/yyyy')
                                    .format(selectedTime),
                                status: FilterStatus.Upcoming.toString(),
                                doctorName: _doctorNameController.text,
                                reservedDate:
                                    DateFormat('HH:MM').format(selectedTime)))
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
}
