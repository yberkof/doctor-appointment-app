// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

Appointment appointmentFromJson(String str) =>
    Appointment.fromJson(json.decode(str));

String appointmentToJson(Appointment data) => json.encode(data.toJson());

class Appointment {
  Appointment({
    required this.doctorName,
    required this.hospitalName,
    required this.reservedDate,
    required this.reservedTime,
    required this.status,
  });

  String doctorName;
  String hospitalName;
  String reservedDate;
  String reservedTime;
  String status;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        doctorName: json["doctorName"],
        hospitalName: json["hospitalName"],
        reservedDate: json["reservedDate"],
        reservedTime: json["reservedTime"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "doctorName": doctorName,
        "hospitalName": hospitalName,
        "reservedDate": reservedDate,
        "reservedTime": reservedTime,
        "status": status,
      };
}
