import 'package:flutter/material.dart';
import 'package:hrm_final_project/Employee-Home/Employee-Committee/committe_job_applicant_detail.dart';
import 'package:hrm_final_project/Models/committee_with_member_for_employ_Model2.dart';
import 'package:hrm_final_project/uri.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class CommitteJobforEmployeeMarking extends StatefulWidget {
  int? uid;
  int? commid;
  int? memberid;

  CommitteJobforEmployeeMarking({
    super.key,
    required this.uid,
    required this.commid,
    required this.memberid,
  });

  @override
  State<CommitteJobforEmployeeMarking> createState() =>
      _CommitteJobforEmployeeMarkingState();
}

class _CommitteJobforEmployeeMarkingState
    extends State<CommitteJobforEmployeeMarking> {
  List<Foremployeecommitteewithmember> employeecommittelist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Jobs For Remarks"),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            FutureBuilder(
                future: getcommitte(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: employeecommittelist
                            .expand(
                                (c) => c.committee!.jobApplicationCommittees!)
                            .length,
                        itemBuilder: (context, index) {
                          var jobapplication = employeecommittelist
                              .expand(
                                  (c) => c.committee!.jobApplicationCommittees!)
                              .toList()[index];
                          return Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.width * 0.02,
                                right:
                                    MediaQuery.of(context).size.width * 0.02),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ApplicantJobDetail(
                                                uid: widget.uid,
                                                applicationid: jobapplication
                                                    .jobApplicationId,
                                                memberid: widget.memberid)));
                              },
                              child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      border: Border.all(
                                          width: 2, color: Colors.black)),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18, left: 5),
                                            child: RichText(
                                              text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: [
                                                    const TextSpan(
                                                      text: "Job Title :  ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${jobapplication.jobApplication!.job!.title}",
                                                      style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 18),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18, left: 5),
                                            child: RichText(
                                              text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: [
                                                    const TextSpan(
                                                      text: "Applicant :  ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${jobapplication.jobApplication!.user!.fname} ${jobapplication.jobApplication!.user!.lname}",
                                                      style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 18),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ));
  }

  Future<List<Foremployeecommitteewithmember>> getcommitte() async {
    // Get the current user's UID.
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Committeemembers/CommitteeWithMemberGet?uid=${widget.uid}&CommitteeId=${widget.commid}'));
    var Data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      employeecommittelist.clear();
      for (Map<String, dynamic> index in Data) {
        var committeeMember = Foremployeecommitteewithmember.fromJson(index);
        committeeMember.committee!.jobApplicationCommittees = committeeMember
            .committee!.jobApplicationCommittees!
            .where((jobApplicationCommittee) {
          return jobApplicationCommittee.committeeId == widget.commid;
        }).toList();
        employeecommittelist.add(committeeMember);
      }
    } else {
      print(
          'Error occurred: ${response.statusCode} - ${response.body}'); // print the error
    }
    return employeecommittelist;
  }
}
