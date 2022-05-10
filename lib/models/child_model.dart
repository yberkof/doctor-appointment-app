// To parse this JSON data, do
//
//     final child = childFromJson(jsonString);

import 'dart:convert';

Child childFromJson(String str) => Child.fromJson(json.decode(str));

String childToJson(Child data) => json.encode(data.toJson());

class Child {
  Child({
    required this.nationalId,
    required this.childName,
    required this.childDateOfBirth,
    required this.takenVaccines,
  });

  String nationalId;
  String childName;
  DateTime childDateOfBirth;
  List<TakenVaccine> takenVaccines;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        nationalId: json["nationalId"],
        childName: json["childName"],
        childDateOfBirth: json["childDateOfBirth"],
        takenVaccines: json["takenVaccines"] == null
            ? <TakenVaccine>[]
            : List<TakenVaccine>.from(
                json["takenVaccines"].map((x) => TakenVaccine.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nationalId": nationalId,
        "childName": childName,
        "childDateOfBirth": childDateOfBirth,
        "takenVaccines":
            List<dynamic>.from(takenVaccines.map((x) => x.toJson())),
      };
}

class TakenVaccine {
  TakenVaccine({
    required this.vaccineName,
  });

  String vaccineName;

  factory TakenVaccine.fromJson(Map<String, dynamic> json) => TakenVaccine(
        vaccineName: json["vaccineName"],
      );

  Map<String, dynamic> toJson() => {
        "vaccineName": vaccineName,
      };
}
