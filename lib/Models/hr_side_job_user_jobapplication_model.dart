// To parse this JSON data, do
//
//     final jobuserjobapplicationmodelDart = jobuserjobapplicationmodelDartFromJson(jsonString);

import 'dart:convert';

JobuserjobapplicationmodelDart jobuserjobapplicationmodelDartFromJson(
        String str) =>
    JobuserjobapplicationmodelDart.fromJson(json.decode(str));

String jobuserjobapplicationmodelDartToJson(
        JobuserjobapplicationmodelDart data) =>
    json.encode(data.toJson());

class JobuserjobapplicationmodelDart {
  int userUid;
  String fname;
  String lname;
  String email;
  String mobile;
  String cnic;
  DateTime dob;
  String gender;
  String address;
  String password;
  String role;
  String image;
  int jobApplicationId;
  int jobApplicationJid;
  int jobApplicationUid;
  String name;
  String status;
  dynamic shortlist;
  String documentPath;
  int jobJid;
  String title;
  String qualification;
  String salary;
  String experience;
  DateTime lastDateOfApply;
  String location;
  String description;
  String jobstatus;
  int noofvacancie;
  bool isitemselected = false;

  JobuserjobapplicationmodelDart({
    required this.userUid,
    required this.fname,
    required this.lname,
    required this.email,
    required this.mobile,
    required this.cnic,
    required this.dob,
    required this.gender,
    required this.address,
    required this.password,
    required this.role,
    required this.image,
    required this.jobApplicationId,
    required this.jobApplicationJid,
    required this.jobApplicationUid,
    required this.name,
    required this.status,
    this.shortlist,
    required this.documentPath,
    required this.jobJid,
    required this.title,
    required this.qualification,
    required this.salary,
    required this.experience,
    required this.lastDateOfApply,
    required this.location,
    required this.description,
    required this.noofvacancie,
    required this.jobstatus,
  });

  factory JobuserjobapplicationmodelDart.fromJson(Map<String, dynamic> json) =>
      JobuserjobapplicationmodelDart(
        userUid: json["UserUid"],
        fname: json["Fname"],
        lname: json["Lname"],
        email: json["email"],
        mobile: json["mobile"],
        cnic: json["cnic"],
        dob: DateTime.parse(json["dob"]),
        gender: json["gender"],
        address: json["address"],
        password: json["password"],
        role: json["role"],
        image: json["image"] ?? '',
        jobApplicationId: json["JobApplicationID"],
        jobApplicationJid: json["JobApplicationJid"],
        jobApplicationUid: json["JobApplicationUid"],
        name: json["name"],
        status: json["status"],
        shortlist: json["shortlist"],
        documentPath: json["DocumentPath"],
        jobJid: json["JobJid"],
        title: json["Title"],
        qualification: json["qualification"],
        salary: json["Salary"],
        experience: json["experience"],
        lastDateOfApply: DateTime.parse(json["LastDateOfApply"]),
        location: json["Location"],
        description: json["Description"],
        noofvacancie: json["noofvacancie"],
        jobstatus: json["jobstatus"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "UserUid": userUid,
        "Fname": fname,
        "Lname": lname,
        "email": email,
        "mobile": mobile,
        "cnic": cnic,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "address": address,
        "password": password,
        "role": role,
        "image": image,
        "JobApplicationID": jobApplicationId,
        "JobApplicationJid": jobApplicationJid,
        "JobApplicationUid": jobApplicationUid,
        "name": name,
        "status": status,
        "shortlist": shortlist,
        "DocumentPath": documentPath,
        "JobJid": jobJid,
        "Title": title,
        "qualification": qualification,
        "Salary": salary,
        "experience": experience,
        "LastDateOfApply":
            "${lastDateOfApply.year.toString().padLeft(4, '0')}-${lastDateOfApply.month.toString().padLeft(2, '0')}-${lastDateOfApply.day.toString().padLeft(2, '0')}",
        "Location": location,
        "Description": description,
        "noofvacancie": noofvacancie,
        "jobstatus": jobstatus,
      };
}
