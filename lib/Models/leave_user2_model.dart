// To parse this JSON data, do
//
//     final leavewithusermodel2 = leavewithusermodel2FromJson(jsonString);

import 'dart:convert';

Leavewithusermodel2 leavewithusermodel2FromJson(String str) =>
    Leavewithusermodel2.fromJson(json.decode(str));

String leavewithusermodel2ToJson(Leavewithusermodel2 data) =>
    json.encode(data.toJson());

class Leavewithusermodel2 {
  int totalPending;
  List<Application> applications;

  Leavewithusermodel2({
    required this.totalPending,
    required this.applications,
  });

  factory Leavewithusermodel2.fromJson(Map<String, dynamic> json) =>
      Leavewithusermodel2(
        totalPending: json["TotalPending"],
        applications: List<Application>.from(
            json["Applications"].map((x) => Application.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TotalPending": totalPending,
        "Applications": List<dynamic>.from(applications.map((x) => x.toJson())),
      };
}

class Application {
  int uid;
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
  int leaveappid;
  String leavetype;
  DateTime startdate;
  DateTime enddate;
  String reason;
  String status;
  DateTime applydate;

  Application({
    required this.uid,
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
    required this.leaveappid,
    required this.leavetype,
    required this.startdate,
    required this.enddate,
    required this.reason,
    required this.status,
    required this.applydate,
  });

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        uid: json["Uid"],
        fname: json["Fname"] ?? '',
        lname: json["Lname"] ?? '',
        email: json["email"] ?? '',
        mobile: json["mobile"] ?? '',
        cnic: json["cnic"] ?? '',
        dob: json["dob"] != null
            ? DateTime.parse(json["dob"])
            : DateTime.now(), // or some other default date
        gender: json["gender"] ?? '',
        address: json["address"] ?? '',
        password: json["password"] ?? '',
        role: json["role"] ?? '',
        image: json["image"] ?? '',
        leaveappid: json["leaveappid"],
        leavetype: json["leavetype"] ?? '',
        startdate: json["startdate"] != null
            ? DateTime.parse(json["startdate"])
            : DateTime.now(),
        enddate: json["enddate"] != null
            ? DateTime.parse(json["enddate"])
            : DateTime.now(),
        reason: json["reason"] ?? '',
        status: json["status"] ?? '',
        applydate: json["applydate"] != null
            ? DateTime.parse(json["applydate"])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "Uid": uid,
        "Fname": fname,
        "Lname": lname,
        "email": email,
        "mobile": mobile,
        "cnic": cnic,
        "dob": dob.toIso8601String(),
        "gender": gender,
        "address": address,
        "password": password,
        "role": role,
        "image": image,
        "leaveappid": leaveappid,
        "leavetype": leavetype,
        "startdate": startdate.toIso8601String(),
        "enddate": enddate.toIso8601String(),
        "reason": reason,
        "status": status,
        "applydate": applydate.toIso8601String(),
      };
}
