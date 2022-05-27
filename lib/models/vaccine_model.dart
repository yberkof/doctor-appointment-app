// To parse this JSON data, do
//
//     final Vaccine = VaccineFromJson(jsonString);

import 'dart:convert';

Vaccine VaccineFromJson(String str) => Vaccine.fromJson(json.decode(str));

String VaccineToJson(Vaccine data) => json.encode(data.toJson());

class Vaccine {
  Vaccine({
    required this.vaccineName,
    required this.vaccineDesc,
    required this.vaccineTime,
    required this.hasSecondDose,
  });

  String vaccineName;
  String vaccineDesc;
  VaccineTime vaccineTime;
  bool hasSecondDose;

  factory Vaccine.fromJson(Map<String, dynamic> json) => Vaccine(
        vaccineName: json["vaccineName"],
        vaccineDesc: json["vaccineDesc"],
        vaccineTime: VaccineTime.fromJson(json["vaccineTime"]),
        hasSecondDose: json["hasSecondDose"],
      );

  Map<String, dynamic> toJson() => {
        "vaccineName": vaccineName,
        "vaccineDesc": vaccineDesc,
        "vaccineTime": vaccineTime.toJson(),
        "hasSecondDose": hasSecondDose,
      };
}

class VaccineTime {
  VaccineTime({
    required this.years,
    required this.months,
    required this.days,
  });

  int years;
  int months;
  int days;

  factory VaccineTime.fromJson(Map<String, dynamic> json) => VaccineTime(
        years: json["years"],
        months: json["months"],
        days: json["days"],
      );

  Map<String, dynamic> toJson() => {
        "years": years,
        "months": months,
        "days": days,
      };
}
