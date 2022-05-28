import 'dart:math';

import 'package:flutter/material.dart';
import 'package:medicare/models/child_model.dart';
import 'package:medicare/models/vaccine_model.dart';
import 'package:medicare/services/vaccines_service.dart';

import '../generated/l10n.dart';

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
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.current.vaccines,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: FutureBuilder<List<Vaccine>>(
                  future: VaccinesService.shared.getVaccines(context),
                  builder: (c, s) {
                    if (!s.hasData) {
                      return CircularProgressIndicator();
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: s.data!.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return Container(
                            height: 75,
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      s.data![index].vaccineName,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
