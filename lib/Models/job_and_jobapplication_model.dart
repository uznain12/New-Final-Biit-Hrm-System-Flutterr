// To parse this JSON data, do
//
//     final jobandJobapplicationmodel = jobandJobapplicationmodelFromJson(jsonString);

import 'dart:convert';

JobandJobapplicationmodel jobandJobapplicationmodelFromJson(String str) =>
    JobandJobapplicationmodel.fromJson(json.decode(str));

String jobandJobapplicationmodelToJson(JobandJobapplicationmodel data) =>
    json.encode(data.toJson());

class JobandJobapplicationmodel {
  int jobApplicationId;
  int jid;
  int uid;
  String name;
  String status;
  String shortlist;
  String documentPath;
  String jobTitle;
  String jobQualification;
  String jobSalary;
  String jobExperience;
  DateTime lastDateOfApply;
  String jobLocation;
  String jobDescription;
  int noOfVacancies;

  JobandJobapplicationmodel({
    required this.jobApplicationId,
    required this.jid,
    required this.uid,
    required this.name,
    required this.status,
    required this.shortlist,
    required this.documentPath,
    required this.jobTitle,
    required this.jobQualification,
    required this.jobSalary,
    required this.jobExperience,
    required this.lastDateOfApply,
    required this.jobLocation,
    required this.jobDescription,
    required this.noOfVacancies,
  });

  factory JobandJobapplicationmodel.fromJson(Map<String, dynamic> json) =>
      JobandJobapplicationmodel(
        jobApplicationId: json["JobApplicationID"],
        jid: json["Jid"],
        uid: json["Uid"],
        name: json["name"] ?? '',
        status: json["status"] ?? '',
        shortlist: json["shortlist"] ?? '',
        documentPath: json["DocumentPath"],
        jobTitle: json["JobTitle"] ?? '',
        jobQualification: json["JobQualification"] ?? '',
        jobSalary: json["JobSalary"] ?? '',
        jobExperience: json["JobExperience"] ?? '',
        lastDateOfApply: DateTime.parse(json["LastDateOfApply"]),
        jobLocation: json["JobLocation"],
        jobDescription: json["JobDescription"],
        noOfVacancies: json["NoOfVacancies"],
      );

  Map<String, dynamic> toJson() => {
        "JobApplicationID": jobApplicationId,
        "Jid": jid,
        "Uid": uid,
        "name": name,
        "status": status,
        "shortlist": shortlist,
        "DocumentPath": documentPath,
        "JobTitle": jobTitle,
        "JobQualification": jobQualification,
        "JobSalary": jobSalary,
        "JobExperience": jobExperience,
        "LastDateOfApply":
            "${lastDateOfApply.year.toString().padLeft(4, '0')}-${lastDateOfApply.month.toString().padLeft(2, '0')}-${lastDateOfApply.day.toString().padLeft(2, '0')}",
        "JobLocation": jobLocation,
        "JobDescription": jobDescription,
        "NoOfVacancies": noOfVacancies,
      };
}
