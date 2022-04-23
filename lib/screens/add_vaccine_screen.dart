import 'package:flutter/material.dart';

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
  late TextEditingController _examDateController;
  DateTime selectedTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vaccineNameController = TextEditingController();
    _vaccineDescController = TextEditingController();
    _examDateController = TextEditingController();
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
                                vaccineTime:
                                    VaccineTime(years: 2, months: 2, days: 2)))
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
