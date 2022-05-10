import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/child_model.dart';
import '../services/child_service.dart';
import '../utils/alert_helper.dart';
import '../widgets/app_textfield.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({Key? key}) : super(key: key);

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  late TextEditingController _nationalIdController;
  late TextEditingController _childNameController;

  DateTime selectedTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nationalIdController = TextEditingController();
    _childNameController = TextEditingController();
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
                title: Text('Add Child'),
              ),
              AppTextField(
                controller: _nationalIdController,
                hint: 'National ID',
                icon: Icons.drive_file_rename_outline,
              ),
              AppTextField(
                controller: _childNameController,
                hint: 'Child Name',
                icon: Icons.vaccines_sharp,
              ),
              DateTimePicker(
                type: DateTimePickerType.date,
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
                    ChildService.shared
                        .addChild(
                            context,
                            Child(
                              childName: _childNameController.text,
                              childDateOfBirth:
                                  DateFormat('dd/MM/yyyy').format(selectedTime),
                              takenVaccines: [],
                              nationalId: _nationalIdController.text,
                            ))
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
