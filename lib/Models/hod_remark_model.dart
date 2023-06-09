// To parse this JSON data, do
//
//     final remarkModel = remarkModelFromJson(jsonString);

import 'dart:convert';

List<RemarkModel> remarkModelFromJson(String str) => List<RemarkModel>.from(json.decode(str).map((x) => RemarkModel.fromJson(x)));

String remarkModelToJson(List<RemarkModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RemarkModel {
    int memberRemarks;
    String committeeMemberName;
    String committeeMemberGender;
    String jobApplicationName;
    int applicantId;
    String applicantName;

    RemarkModel({
        required this.memberRemarks,
        required this.committeeMemberName,
        required this.committeeMemberGender,
        required this.jobApplicationName,
        required this.applicantId,
        required this.applicantName,
    });

    factory RemarkModel.fromJson(Map<String, dynamic> json) => RemarkModel(
        memberRemarks: json["MemberRemarks"],
        committeeMemberName: json["CommitteeMemberName"],
        committeeMemberGender: json["CommitteeMemberGender"],
        jobApplicationName: json["JobApplicationName"],
        applicantId: json["ApplicantID"],
        applicantName: json["ApplicantName"],
    );

    Map<String, dynamic> toJson() => {
        "MemberRemarks": memberRemarks,
        "CommitteeMemberName": committeeMemberName,
        "CommitteeMemberGender": committeeMemberGender,
        "JobApplicationName": jobApplicationName,
        "ApplicantID": applicantId,
        "ApplicantName": applicantName,
    };
}
