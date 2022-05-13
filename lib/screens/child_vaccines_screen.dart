import 'dart:math';

import 'package:flutter/material.dart';
import 'package:medicare/models/child_model.dart';
import 'package:medicare/models/vaccine_model.dart';
import 'package:medicare/services/vaccines_service.dart';

class ChildVaccinesScreen extends StatefulWidget {
  final Child child;

  const ChildVaccinesScreen({Key? key, required this.child}) : super(key: key);

  @override
  _ChildVaccinesScreenState createState() => _ChildVaccinesScreenState();
}

class _ChildVaccinesScreenState extends State<ChildVaccinesScreen> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 300,
        height: 500,
        child: FutureBuilder<List<Vaccine>>(
          future: VaccinesService.shared.getVaccines(context),
          builder: (c, s) {
            if (!s.hasData) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
                itemCount: s.data!.length,
                itemBuilder: ((context, index) {
                  return Row(
                    children: [
                      widget.child.takenVaccines
                              .where((element) =>
                                  element.vaccineName ==
                                  s.data![index].vaccineName)
                              .isNotEmpty
                          ? Icon(
                              Icons.verified,
                              color: Colors.green,
                            )
                          : Transform.rotate(
                              angle: 45 * pi / 180,
                              child: Icon(
                                Icons.add_circle_outline,
                                color: Colors.red,
                              ),
                            ),
                      Text(s.data![index].vaccineName)
                    ],
                  );
                }));
          },
        ),
      ),
    );
  }
}
