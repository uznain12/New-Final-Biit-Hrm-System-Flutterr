// To parse this JSON data, do
//
//     final experienicemodel = experienicemodelFromJson(jsonString);

import 'dart:convert';

Experienicemodel experienicemodelFromJson(String str) =>
    Experienicemodel.fromJson(json.decode(str));

String experienicemodelToJson(Experienicemodel data) =>
    json.encode(data.toJson());

class Experienicemodel {
  int expId;
  int uid;
  String company;
  String title;
  DateTime startdate;
  String currentwork;
  DateTime enddate;
  String otherskill;

  Experienicemodel({
    required this.expId,
    required this.uid,
    required this.company,
    required this.title,
    required this.startdate,
    required this.currentwork,
    required this.enddate,
    required this.otherskill,
  });

  factory Experienicemodel.fromJson(Map<String, dynamic> json) =>
      Experienicemodel(
        expId: json["ExpID"],
        uid: json["Uid"],
        company: json["Company"],
        title: json["Title"],
        startdate: DateTime.parse(json["Startdate"]),
        currentwork: json["currentwork"] ?? '',
        enddate: json["enddate"] != null
            ? DateTime.parse(json["enddate"])
            : DateTime.now(),
        otherskill: json["otherskill"],
      );

  Map<String, dynamic> toJson() => {
        "ExpID": expId,
        "Uid": uid,
        "Company": company,
        "Title": title,
        "Startdate":
            "${startdate.year.toString().padLeft(4, '0')}-${startdate.month.toString().padLeft(2, '0')}-${startdate.day.toString().padLeft(2, '0')}",
        "currentwork": currentwork,
        "Enddate": enddate.toIso8601String(),
        "otherskill": otherskill,
      };
}
