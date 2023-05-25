// To parse this JSON data, do
//
//     final educationmodel = educationmodelFromJson(jsonString);

import 'dart:convert';

Educationmodel educationmodelFromJson(String str) =>
    Educationmodel.fromJson(json.decode(str));

String educationmodelToJson(Educationmodel data) => json.encode(data.toJson());

class Educationmodel {
  int eduId;
  int uid;
  String degree;
  String major;
  String institute;
  String board;
  DateTime startdate;
  DateTime enddate;

  Educationmodel({
    required this.eduId,
    required this.uid,
    required this.degree,
    required this.major,
    required this.institute,
    required this.board,
    required this.startdate,
    required this.enddate,
  });

  factory Educationmodel.fromJson(Map<String, dynamic> json) => Educationmodel(
        eduId: json["EduID"],
        uid: json["Uid"] ?? 0,
        degree: json["Degree"] ?? '',
        major: json["major"] ?? '',
        institute: json["Institute"] ?? '',
        board: json["Board"] ?? '',
        startdate: DateTime.parse(json["Startdate"]),
        enddate: DateTime.parse(json["Enddate"]),
      );

  Map<String, dynamic> toJson() => {
        "EduID": eduId,
        "Uid": uid,
        "Degree": degree,
        "major": major,
        "Institute": institute,
        "Board": board,
        "Startdate": startdate.toIso8601String(),
        "Enddate": enddate.toIso8601String(),
      };
}
