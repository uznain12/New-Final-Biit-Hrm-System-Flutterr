// To parse this JSON data, do
//
//     final leavewithusermodel3 = leavewithusermodel3FromJson(jsonString);

import 'dart:convert';

Leavewithusermodel3 leavewithusermodel3FromJson(String str) =>
    Leavewithusermodel3.fromJson(json.decode(str));

String leavewithusermodel3ToJson(Leavewithusermodel3 data) =>
    json.encode(data.toJson());

class Leavewithusermodel3 {
  int totalSick;
  int totalCasual;
  int totalEarned;
  int totalAnnual;
  int maxSickAllow;
  int maxCasualAllow;
  int maxEarnedAllow;
  int maxAnnualAllow;
  int remainingSick;
  int remainingCasual;
  int remainingEarned;
  int remainingAnnual;
  List<Application> applications;

  Leavewithusermodel3({
    required this.totalSick,
    required this.totalCasual,
    required this.totalEarned,
    required this.totalAnnual,
    required this.maxSickAllow,
    required this.maxCasualAllow,
    required this.maxEarnedAllow,
    required this.maxAnnualAllow,
    required this.remainingSick,
    required this.remainingCasual,
    required this.remainingEarned,
    required this.remainingAnnual,
    required this.applications,
  });

  factory Leavewithusermodel3.fromJson(Map<String, dynamic> json) =>
      Leavewithusermodel3(
        totalSick: json["TotalSick"] ?? 0,
        totalCasual: json["TotalCasual"] ?? 0,
        totalEarned: json["TotalEarned"] ?? 0,
        totalAnnual: json["TotalAnnual"] ?? 0,
        maxSickAllow: json["MaxSickAllow"] ?? 0,
        maxCasualAllow: json["MaxCasualAllow"] ?? 0,
        maxEarnedAllow: json["MaxEarnedAllow"] ?? 0,
        maxAnnualAllow: json["MaxAnnualAllow"] ?? 0,
        remainingSick: json["RemainingSick"] ?? 0,
        remainingCasual: json["RemainingCasual"] ?? 0,
        remainingEarned: json["RemainingEarned"] ?? 0,
        remainingAnnual: json["RemainingAnnual"] ?? 0,
        applications: List<Application>.from(
            json["Applications"].map((x) => Application.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TotalSick": totalSick,
        "TotalCasual": totalCasual,
        "TotalEarned": totalEarned,
        "TotalAnnual": totalAnnual,
        "MaxSickAllow": maxSickAllow,
        "MaxCasualAllow": maxCasualAllow,
        "MaxEarnedAllow": maxEarnedAllow,
        "MaxAnnualAllow": maxAnnualAllow,
        "RemainingSick": remainingSick,
        "RemainingCasual": remainingCasual,
        "RemainingEarned": remainingEarned,
        "RemainingAnnual": remainingAnnual,
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
