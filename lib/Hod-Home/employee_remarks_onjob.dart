import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hrm_final_project/Hod-Home/select_role_hire.dart';

import 'package:hrm_final_project/Models/hod_remark_model.dart';
import 'package:hrm_final_project/uri.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class EmployeeRemarksOnjob extends StatefulWidget {
  int? appuid;
  int? jobappid;
  int? Jid;
  String? DocumentPath;

  EmployeeRemarksOnjob(
      {super.key,
      required this.appuid,
      required this.jobappid,
      required this.Jid,
      required this.DocumentPath});

  @override
  State<EmployeeRemarksOnjob> createState() => _EmployeeRemarksOnjobState();
}

class _EmployeeRemarksOnjobState extends State<EmployeeRemarksOnjob> {
  List<RemarkModel> remarklist = [];
  File? documentPath;
  @override
  void initState() {
    super.initState();
    if (widget.DocumentPath == null) {
      print("jobappid is null");
      // Handle the case when jobappid is null
    } else {
      print("jobappid is not null");
      print("jobappid: ${widget.DocumentPath}");
      // Handle the case when jobappid is not null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selection  Screen "),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FutureBuilder<List<RemarkModel>>(
            future: getEmployeeRemarks(widget.jobappid!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return const Text('Error occurred');
              } else {
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                        left: MediaQuery.of(context).size.width * 0.02,
                        right: MediaQuery.of(context).size.width * 0.02,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 500,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            border: Border.all(width: 2, color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 18,
                                  left: 5,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      const TextSpan(
                                        text: "Job Title:                 ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      TextSpan(
                                        text: remarklist[index]
                                            .jobApplicationName,
                                        style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 18,
                                  left: 5,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      const TextSpan(
                                        text: "Applicant Name:    ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      TextSpan(
                                        text: remarklist[0].applicantName,
                                        style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Center(
                                  child: Text(
                                "Committee Member Remarks",
                                style:
                                    TextStyle(fontSize: 25, color: Colors.blue),
                              )),
                              const SizedBox(height: 20),
                              const Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    Text(
                                      "Member Name",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      "Remarks(10)",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              const Text(
                                  "---------------------------------------------------------------------------------------"),
                              FutureBuilder(
                                  future: getEmployeeRemarks(widget.jobappid!),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      print('Error: ${snapshot.error}');
                                      return const Text('Error occurred');
                                    } else {
                                      return Expanded(
                                        child: ListView.builder(
                                          itemCount: remarklist.length,
                                          itemBuilder: (context, innerIndex) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8, left: 5),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 40),
                                                child: Row(
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        style:
                                                            DefaultTextStyle.of(
                                                                    context)
                                                                .style,
                                                        children: [
                                                          const TextSpan(
                                                            text: "",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          ),
                                                          TextSpan(
                                                            text: remarklist[
                                                                    innerIndex]
                                                                .committeeMemberName,
                                                            style: const TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 18),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 130),
                                                    Expanded(
                                                      child: Text(
                                                        remarklist[innerIndex]
                                                            .memberRemarks
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  }),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 100),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SelectRole(
                                                        Jid: widget.Jid,
                                                        appuid: widget.appuid,
                                                        jobappid:
                                                            widget.jobappid,
                                                      )));
                                        },
                                        child: Text("Hire")),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          UpdateUser();
                                        },
                                        child: Text("Reject"))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<List<RemarkModel>> getEmployeeRemarks(int jobappid) async {
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Remark/MembersRemarksGet?jobid=$jobappid&Jid=${widget.Jid}&Uid=${widget.appuid}&DocumentPath=${widget.DocumentPath}'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      remarklist.clear();
      for (Map<String, dynamic> index in data) {
        remarklist.add(RemarkModel.fromJson(index));
      }
    } else {
      print(
          'Error occurred: ${response.statusCode} - ${response.body}'); // print the error
    }
    return remarklist;
  }

  void UpdateUser() async {
    var url =
        "http://$ip/HrmPractise02/api/JobApplication/UpdateJobapplication";
    var data = {
      "JobApplicationID": widget.jobappid,
      "Jid": widget.Jid,
      "Uid": widget.appuid,
      "status": "Rejected",

      // Change this to the appropriate value
    };
    var boddy = jsonEncode(data);
    var urlParse = Uri.parse(url);
    try {
      http.Response response = await http.put(urlParse,
          body: boddy, headers: {"Content-Type": "application/json"});
      var dataa = jsonDecode(response.body);
      print(dataa);
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
