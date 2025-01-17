// To parse this JSON data, do
//
//     final child = childFromJson(jsonString);

import 'dart:convert';

Child childFromJson(String str) => Child.fromJson(json.decode(str));

String childToJson(Child data) => json.encode(data.toJson());

class Child {
  Child(
      {required this.nationalId,
      required this.childName,
      required this.childDateOfBirth,
      required this.takenVaccines,
      required this.parentId});

  String nationalId;
  String parentId;
  String childName;
  String childDateOfBirth;
  List<TakenVaccine> takenVaccines;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        nationalId: json["nationalId"],
        childName: json["childName"],
        childDateOfBirth: json["childDateOfBirth"],
        parentId: json["parentId"],
        takenVaccines: json["takenVaccines"] == null
            ? <TakenVaccine>[]
            : List<TakenVaccine>.from(
                json["takenVaccines"].map((x) => TakenVaccine.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "nationalId": nationalId,
        "childName": childName,
        "childDateOfBirth": childDateOfBirth,
        'parentId': parentId,
        "takenVaccines":
            List<dynamic>.from(takenVaccines.map((x) => x.toJson())),
      };
}

class TakenVaccine {
  bool isSecondDose;

  TakenVaccine({
    required this.vaccineName,
    required this.isSecondDose,
  });

  String vaccineName;

  factory TakenVaccine.fromJson(Map<String, dynamic> json) => TakenVaccine(
        vaccineName: json["vaccineName"],
        isSecondDose: json["isSecondDose"],
      );

  Map<String, dynamic> toJson() =>
      {
        "vaccineName": vaccineName,
        "isSecondDose": isSecondDose,
      };
}
