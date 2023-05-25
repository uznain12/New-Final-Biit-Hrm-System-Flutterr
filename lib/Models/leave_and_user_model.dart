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
  dynamic applydate;

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
    this.applydate,
  });

  factory Leavewithusermodel.fromJson(Map<String, dynamic> json) =>
      Leavewithusermodel(
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
        startdate: json["startdate"],
        enddate: json["enddate"],
        reason: json["reason"],
        status: json["status"],
        applydate: json["applydate"],
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
        "startdate": startdate,
        "enddate": enddate,
        "reason": reason,
        "status": status,
        "applydate": applydate,
      };
}
