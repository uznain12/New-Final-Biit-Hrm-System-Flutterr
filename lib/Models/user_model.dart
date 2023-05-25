// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);

import 'dart:convert';

Usermodel usermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

String usermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
  int uid;
  String fname;
  String lname;
  String email;
  String mobile;
  String cnic;
  String dob;
  String gender;
  String address;
  String password;
  String role;
  String image;

  Usermodel({
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
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
        uid: json["Uid"],
        fname: json["Fname"] ?? "",
        lname: json["Lname"] ?? '',
        email: json["email"] ?? '',
        mobile: json["mobile"] ?? '',
        cnic: json["cnic"] ?? '',
        dob: json["dob"] ?? '', // or some other default date

        gender: json["gender"] ?? '',
        address: json["address"] ?? '',
        password: json["password"] ?? '',
        role: json["role"],
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Uid": uid,
        "Fname": fname,
        "Lname": lname,
        "email": email,
        "mobile": mobile,
        "cnic": cnic,
        "dob": dob,
        "gender": gender,
        "address": address,
        "password": password,
        "role": role,
        "image": image,
      };
}
