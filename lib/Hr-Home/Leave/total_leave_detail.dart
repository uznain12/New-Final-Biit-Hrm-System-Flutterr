import 'package:flutter/material.dart';
import 'package:hrm_final_project/Models/leave-user-3.dart';

import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class TotalLeaveDetailOfApplicant extends StatefulWidget {
  final int leavid;
  int? uid;
  String? reson;
  String? leavetype;
  String? sdate;
  String? edate;
  DateTime? apdate;

  // ignore: prefer_const_constructors_in_immutables
  TotalLeaveDetailOfApplicant({
    super.key,
    required this.leavid,
    required this.uid,
    required this.sdate,
    required this.edate,
    required this.apdate,
    required this.reson,
    required this.leavetype,
  });

  @override
  State<TotalLeaveDetailOfApplicant> createState() =>
      _TotalLeaveDetailOfApplicantState();
}

class _TotalLeaveDetailOfApplicantState
    extends State<TotalLeaveDetailOfApplicant> {
  List<Leavewithusermodel3> laveapplicationlist = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application Detail"),
        centerTitle: true,
      ),
      body: Stack(children: [
        FutureBuilder<List<Leavewithusermodel3>>(
          future: fetchleaveapplication(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: laveapplicationlist.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            height: 800,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              border: Border.all(width: 4, color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Applicant Name:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${laveapplicationlist[index].applications[index].fname} ${laveapplicationlist[index].applications[index].lname}",
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Leave Type:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${laveapplicationlist[index].applications[index].leavetype}",
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "From Date:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${laveapplicationlist[index].applications[index].startdate}",
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "To Date:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${laveapplicationlist[index].applications[index].enddate}",
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Reason:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${laveapplicationlist[index].applications[index].reason}",
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          approveleave(context: context);
                                        },
                                        child: const Text("Approve"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          rejectleave(
                                            context: context,
                                          );
                                        },
                                        child: const Text("Reject"),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                      "---------------------------------------------------------------------------------------"),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: 1,
                                      itemBuilder: (context, snapshot) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 40),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: [
                                                    const TextSpan(
                                                      text: "Casual Take:   ",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    TextSpan(
                                                      text: laveapplicationlist[
                                                              index]
                                                          .totalCasual
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 40),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: [
                                                    const TextSpan(
                                                      text: "Annual Take:   ",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    TextSpan(
                                                      text: laveapplicationlist[
                                                              index]
                                                          .totalAnnual
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 40),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: [
                                                    const TextSpan(
                                                      text: "Earned Take:   ",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    TextSpan(
                                                      text: laveapplicationlist[
                                                              index]
                                                          .totalEarned
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 40),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: [
                                                    const TextSpan(
                                                      text: "Sick Take:   ",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    TextSpan(
                                                      text: laveapplicationlist[
                                                              index]
                                                          .totalSick
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ]),
    );
  }

  Future<List<Leavewithusermodel3>> fetchleaveapplication() async {
    //response keyword khud sa bnaya ha
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Extra/AgainnewRemainingTotalNewLeaveWithIDGet?uid=${widget.uid}&leaveappid=${widget.leavid}')); // is ma aik variable bnaya ha response ka name sa or phir get method ka through api ko hit kar rahay hn is ka data aik data variable ma store karway ga
    var Data = jsonDecode(response.body
        .toString()); // decode kar ka data variable ma store kar rahay hn
    if (response.statusCode == 200) {
      laveapplicationlist.clear();

      if (Data is Map<String, dynamic>) {
        laveapplicationlist.add(Leavewithusermodel3.fromJson(Data));
      } else if (Data is List) {
        for (Map<String, dynamic> index in Data) {
          laveapplicationlist.add(Leavewithusermodel3.fromJson(index));
        }
      }
      return laveapplicationlist;
    } else {
      return laveapplicationlist;
    }
  }

  void rejectleave({
    BuildContext? context,
  }) async {
    var url = "http://$ip/HrmPractise02/api/Leave/UpdateLeave";
    var data = {
      "leaveappid": widget.leavid,
      "Uid": widget.uid,
      "startdate": widget.sdate,
      "reason": widget.reson,
      "enddate": widget.edate,
      "leavetype": widget.leavetype,
      "applydate": widget.apdate?.toIso8601String() ?? "",
      "status": 'rejected'
    };
    var boddy = jsonEncode(data);
    var urlParse = Uri.parse(url);
    try {
      http.Response response = await http.put(urlParse,
          body: boddy, headers: {"Content-Type": "application/json"});
      var dataa = jsonDecode(response.body);
      print(dataa);

      if (response.statusCode == 200) {
        // Navigate to the previous screen if the request was successful
        if (context != null) Navigator.pop(context);
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  void approveleave({
    BuildContext? context,
  }) async {
    var url = "http://$ip/HrmPractise02/api/Leave/UpdateLeave";
    var data = {
      "leaveappid": widget.leavid,
      "Uid": widget.uid,
      "startdate": widget.sdate,
      "reason": widget.reson,
      "enddate": widget.edate,
      "leavetype": widget.leavetype,
      "applydate": widget.apdate?.toIso8601String() ?? "",
      "status": 'approved'
    };

    var boddy = jsonEncode(data);
    var urlParse = Uri.parse(url);
    try {
      http.Response response = await http.put(urlParse,
          body: boddy, headers: {"Content-Type": "application/json"});
      var dataa = jsonDecode(response.body);
      print(dataa);

      if (response.statusCode == 200) {
        // Navigate to the previous screen if the request was successful
        if (context != null) Navigator.pop(context);
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
