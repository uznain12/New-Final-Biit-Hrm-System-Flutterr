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
        image: json["image"],
        leaveappid: json["leaveappid"],
        leavetype: json["leavetype"],
        startdate: DateTime.parse(json["startdate"]),
        enddate: DateTime.parse(json["enddate"]),
        reason: json["reason"],
        status: json["status"],
        applydate: DateTime.parse(json["applydate"]),
      );

  Map<String, dynamic> toJson() => {
        "Uid": uid,
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
        "leaveappid": leaveappid,
        "leavetype": leavetype,
        "startdate":
            "${startdate.year.toString().padLeft(4, '0')}-${startdate.month.toString().padLeft(2, '0')}-${startdate.day.toString().padLeft(2, '0')}",
        "enddate":
            "${enddate.year.toString().padLeft(4, '0')}-${enddate.month.toString().padLeft(2, '0')}-${enddate.day.toString().padLeft(2, '0')}",
        "reason": reason,
        "status": status,
        "applydate": applydate.toIso8601String(),
      };
}
