// To parse this JSON data, do
//
//     final jobapplicationmodel = jobapplicationmodelFromJson(jsonString);

import 'dart:convert';

Jobapplicationmodel jobapplicationmodelFromJson(String str) =>
    Jobapplicationmodel.fromJson(json.decode(str));

String jobapplicationmodelToJson(Jobapplicationmodel data) =>
    json.encode(data.toJson());

class Jobapplicationmodel {
  int jobApplicationId;
  int jid;
  int uid;
  String name;
  String status;
  dynamic shortlist;
  String documentPath;

  Jobapplicationmodel({
    required this.jobApplicationId,
    required this.jid,
    required this.uid,
    required this.name,
    required this.status,
    this.shortlist,
    required this.documentPath,
  });

  factory Jobapplicationmodel.fromJson(Map<String, dynamic> json) =>
      Jobapplicationmodel(
        jobApplicationId: json["JobApplicationID"],
        jid: json["Jid"],
        uid: json["Uid"],
        name: json["name"] ?? '',
        status: json["status"] ?? '',
        shortlist: json["shortlist"] ?? '',
        documentPath: json["DocumentPath"],
      );

  Map<String, dynamic> toJson() => {
        "JobApplicationID": jobApplicationId,
        "Jid": jid,
        "Uid": uid,
        "name": name,
        "status": status,
        "shortlist": shortlist,
        "DocumentPath": documentPath,
      };
}
