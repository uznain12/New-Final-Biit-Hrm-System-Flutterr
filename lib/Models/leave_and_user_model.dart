// To parse this JSON data, do
//
//     final leavewithusermodel = leavewithusermodelFromJson(jsonString);

import 'dart:convert';

Leavewithusermodel leavewithusermodelFromJson(String str) =>
    Leavewithusermodel.fromJson(json.decode(str));

String leavewithusermodelToJson(Leavewithusermodel data) =>
    json.encode(data.toJson());

class Leavewithusermodel {
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
  String startdate;
  String enddate;
  String reason;
  String status;
  DateTime applydate;

  Leavewithusermodel({
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

  factory Leavewithusermodel.fromJson(Map<String, dynamic> json) =>
      Leavewithusermodel(
        uid: json["Uid"],
        fname: json["Fname"],
        lname: json["Lname"],
        email: json["email"],
        mobile: json["mobile"] ?? '',
        cnic: json["cnic"] ?? '',
        dob: json["dob"] != null
            ? DateTime.parse(json["dob"])
            : DateTime.now(), // or some other default date
        gender: json["gender"] ?? '',
        address: json["address"] ?? '',
        password: json["password"],
        role: json["role"],
        image: json["image"] ?? '',
        leaveappid: json["leaveappid"] ?? 0,
        leavetype: json["leavetype"] ?? '',
        startdate: json["startdate"] ?? '',
        enddate: json["enddate"] ?? '',
        reason: json["reason"] ?? '',
        status: json["status"],
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
        "startdate": startdate,
        "enddate": enddate,
        "reason": reason,
        "status": status,
        "applydate": applydate.toIso8601String(),
      };
}
