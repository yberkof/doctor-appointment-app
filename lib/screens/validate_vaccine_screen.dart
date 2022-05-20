import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicare/models/child_model.dart';
import 'package:medicare/models/vaccine_model.dart';
import 'package:medicare/services/child_service.dart';
import 'package:medicare/services/vaccines_service.dart';

import '../utils/alert_helper.dart';

class ValidateVaccineScreen extends StatefulWidget {
  final Child child;

  const ValidateVaccineScreen({Key? key, required this.child})
      : super(key: key);

  @override
  State<ValidateVaccineScreen> createState() => _ValidateVaccineScreenState();
}

class _ValidateVaccineScreenState extends State<ValidateVaccineScreen> {
  DateTime selectedTime = DateTime.now();

  late String _vaccineName = "";

  List<Vaccine>? _vaccines;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                title: Text('Validate Vaccine'),
              ),
              _vaccines != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'National ID: ' + widget.child.nationalId,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
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
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    AlertHelper.showProgressDialog(context);
                    widget.child.takenVaccines
                        .add(TakenVaccine(vaccineName: _vaccineName));
                    ChildService.shared
                        .updateChild(context, widget.child)
                        .then((value) => Navigator.pop(context));
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
}
