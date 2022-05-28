// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

Appointment appointmentFromJson(String str) =>
    Appointment.fromJson(json.decode(str));

String appointmentToJson(Appointment data) => json.encode(data.toJson());

class Appointment {
  Appointment(
      {required this.doctorName,
      required this.vaccineName,
      required this.reservedDate,
      required this.reservedTime,
      required this.status,
      required this.isSecondDose,
      required this.region});

  String doctorName;
  String vaccineName;
  String reservedDate;
  String reservedTime;
  String status;
  bool isSecondDose;
  String region;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        doctorName: json["doctorName"],
        vaccineName: json["vaccineName"],
        reservedDate: json["reservedDate"],
        reservedTime: json["reservedTime"],
        status: json["status"],
        isSecondDose: json["isSecondDose"],
        region: json["region"],
      );

  Map<String, dynamic> toJson() => {
        "doctorName": doctorName,
        "vaccineName": vaccineName,
        "reservedDate": reservedDate,
        "reservedTime": reservedTime,
        "status": status,
        "isSecondDose": isSecondDose,
        "region": region,
      };
}
