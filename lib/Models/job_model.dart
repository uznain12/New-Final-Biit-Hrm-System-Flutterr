// To parse this JSON data, do
//
//     final jobmodel = jobmodelFromJson(jsonString);

import 'dart:convert';

Jobmodel jobmodelFromJson(String str) => Jobmodel.fromJson(json.decode(str));

String jobmodelToJson(Jobmodel data) => json.encode(data.toJson());

class Jobmodel {
  int jid;
  String title;
  String qualification;
  String salary;
  String experience;
  DateTime lastDateOfApply;
  String location;
  String description;
  int noofvacancie;

  Jobmodel({
    required this.jid,
    required this.title,
    required this.qualification,
    required this.salary,
    required this.experience,
    required this.lastDateOfApply,
    required this.location,
    required this.description,
    required this.noofvacancie,
  });

  factory Jobmodel.fromJson(Map<String, dynamic> json) => Jobmodel(
        jid: json["Jid"],
        title: json["Title"],
        qualification: json["qualification"],
        salary: json["Salary"],
        experience: json["experience"],
        lastDateOfApply: DateTime.parse(json["LastDateOfApply"]),
        location: json["Location"],
        description: json["Description"],
        noofvacancie: json["noofvacancie"],
      );

  Map<String, dynamic> toJson() => {
        "Jid": jid,
        "Title": title,
        "qualification": qualification,
        "Salary": salary,
        "experience": experience,
        "LastDateOfApply":
            "${lastDateOfApply.year.toString().padLeft(4, '0')}-${lastDateOfApply.month.toString().padLeft(2, '0')}-${lastDateOfApply.day.toString().padLeft(2, '0')}",
        "Location": location,
        "Description": description,
        "noofvacancie": noofvacancie,
      };
}
