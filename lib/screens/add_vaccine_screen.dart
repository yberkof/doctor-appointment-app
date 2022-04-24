import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/vaccine_model.dart';
import '../services/vaccines_service.dart';
import '../utils/alert_helper.dart';
import '../widgets/app_textfield.dart';

class AddVaccineScreen extends StatefulWidget {
  const AddVaccineScreen({Key? key}) : super(key: key);

  @override
  State<AddVaccineScreen> createState() => _AddVaccineScreenState();
}

class _AddVaccineScreenState extends State<AddVaccineScreen> {
  late TextEditingController _vaccineNameController;
  late TextEditingController _vaccineDescController;
  late TextEditingController _yearsController;
  late TextEditingController _monthsController;
  late TextEditingController _daysController;
  DateTime selectedTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vaccineNameController = TextEditingController();
    _vaccineDescController = TextEditingController();
    _yearsController = TextEditingController();
    _monthsController = TextEditingController();
    _daysController = TextEditingController();
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
                    title: Text('Add Vaccine'),
                  ),
              AppTextField(
                controller: _vaccineNameController,
                hint: 'Vaccine Name',
                icon: Icons.drive_file_rename_outline,
              ),
              AppTextField(
                controller: _vaccineDescController,
                hint: 'Vaccine Description',
                icon: Icons.description_outlined,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    controller: _yearsController,
                    hint: 'Years',
                    width: MediaQuery.of(context).size.width * 0.30,
                    icon: (Icons.date_range),
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CustomRangeTextInputFormatter(18)
                    ],
                  ),
                  AppTextField(
                    controller: _monthsController,
                    hint: 'Months',
                    width: MediaQuery.of(context).size.width * 0.30,
                    icon: (Icons.date_range),
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CustomRangeTextInputFormatter(12)
                    ],
                  ),
                  AppTextField(
                    controller: _daysController,
                    hint: 'Days',
                    width: MediaQuery.of(context).size.width * 0.30,
                    icon: (Icons.date_range),
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CustomRangeTextInputFormatter(31)
                    ],
                  ),
                ],
              ),

              // InkWell(
              //   onTap: (){
              //
              //   },
              //   child: AbsorbPointer(
              //     absorbing: true,
              //     child: AppTextField(
              //       controller: _examDateController,
              //       hint: S.current.courseName,
              //       icon: Icons.update,
                  //     ),
                  //   ),
                  // ),

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
                        VaccinesService.shared
                            .addVaccine(
                            context,
                            Vaccine(
                                vaccineDesc: _vaccineDescController.text,
                                vaccineName: _vaccineNameController.text,
                                vaccineTime: VaccineTime(
                                    years: int.parse(_yearsController.text),
                                    months: int.parse(_monthsController.text),
                                    days: int.parse(_daysController.text))))
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
