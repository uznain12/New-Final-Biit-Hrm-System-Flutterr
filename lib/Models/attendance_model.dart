// To parse this JSON data, do
//
//     final attendancemodel = attendancemodelFromJson(jsonString);

import 'dart:convert';

Attendancemodel attendancemodelFromJson(String str) =>
    Attendancemodel.fromJson(json.decode(str));

String attendancemodelToJson(Attendancemodel data) =>
    json.encode(data.toJson());

class Attendancemodel {
  int attendanceid;
  int uid;
  DateTime date;
  String checkin;
  String status;
  String checkout;

  Attendancemodel({
    required this.attendanceid,
    required this.uid,
    required this.date,
    required this.checkin,
    required this.status,
    required this.checkout,
  });

  factory Attendancemodel.fromJson(Map<String, dynamic> json) =>
      Attendancemodel(
        attendanceid: json["Attendanceid"],
        uid: json["Uid"],
        date: json["date"] != null
            ? DateTime.parse(json["date"])
            : DateTime.now(), // or some other default date

        checkin: json["checkin"] ?? '',
        status: json["status"] ?? '',
        checkout: json["checkout"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Attendanceid": attendanceid,
        "Uid": uid,
        "date": date.toIso8601String(),
        "checkin": checkin,
        "status": status,
        "checkout": checkout,
      };
}
