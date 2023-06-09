import 'package:flutter/material.dart';
import 'package:hrm_final_project/Employee-Home/Employee-Leave/employee_all_leave_applications.dart';
import 'package:hrm_final_project/Employee-Home/Employee-Leave/employee_approved_leaves.dart';
import 'package:hrm_final_project/Employee-Home/Employee-Leave/employee_rejected_leaves.dart';

import 'package:hrm_final_project/Models/leave_user2_model.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class EmployeePendingLeave extends StatefulWidget {
  int? uid;
  EmployeePendingLeave({super.key, required this.uid});

  @override
  State<EmployeePendingLeave> createState() => _EmployeePendingLeaveState();
}

class _EmployeePendingLeaveState extends State<EmployeePendingLeave> {
  List<Leavewithusermodel2> laveapplicationlist = [];
  String _formatDate(DateTime date) {
    //ya date ko sai sa show karwanay ka liya bnaya ha like is format ma show hogi date
    return DateFormat('yyyy-MM-dd').format(date);
  }

  late Widget _widget;
  @override
  void initState() {
    super.initState();
    _widget = EmployeePendingLeave(uid: widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Leave Applications"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: fetchleaveapplication(widget.uid!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceAround, // distribute buttons evenly
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EmployeeLeaveApplication(
                                          uid: widget.uid,
                                        )));
                            // button press code here
                          },
                          child: Text('All'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmployeeApprovedLeave(
                                          uid: widget.uid,
                                        )));
                            // button press code here
                          },
                          child: Text('Approved'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmployeeRejectedLeave(
                                          uid: widget.uid,
                                        )));
                            // button press code here
                          },
                          child: Text('Rejected'),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: laveapplicationlist.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.03),
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    border: Border.all(
                                        width: 4, color: Colors.black)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.03),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // RichText(
                                      //   text: TextSpan(
                                      //       style: DefaultTextStyle.of(context).style,
                                      //       children: [
                                      //         const TextSpan(
                                      //           text: "First Name: ",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //           ),
                                      //         ),
                                      //         TextSpan(
                                      //           text: "${userlist[index].fname}",
                                      //           style: const TextStyle(
                                      //             fontStyle: FontStyle.italic,
                                      //           ),
                                      //         ),
                                      //       ]),
                                      // ),
                                      // Text("First Name: ${userlist[index].fname}"),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: RichText(
                                          text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: [
                                                const TextSpan(
                                                  text:
                                                      "Total Pending Leaves:                 ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      // ignore: unnecessary_string_interpolations
                                                      "${laveapplicationlist[index].totalPending}",
                                                  style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: RichText(
                                          text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: [
                                                const TextSpan(
                                                  text:
                                                      "Leave Type:                 ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      // ignore: unnecessary_string_interpolations
                                                      "${laveapplicationlist[index].applications[index].leavetype}",
                                                  style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: RichText(
                                          text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: [
                                                const TextSpan(
                                                  text: "Apply Date :    ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      // "${laveapplicationlist[index].applydate.toString()} ",
                                                      "${_formatDate(DateTime.parse(laveapplicationlist[index].applications[index].applydate.toString()))}",
                                                  style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: RichText(
                                          text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: [
                                                const TextSpan(
                                                  text: "Status :    ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${laveapplicationlist[index].applications[index].status} ",
                                                  style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      // RichText(
                                      //   text: TextSpan(
                                      //       style: DefaultTextStyle.of(context).style,
                                      //       children: [
                                      //         const TextSpan(
                                      //           text: "Date Of Birth: ",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //           ),
                                      //         ),
                                      //         TextSpan(
                                      //           text: "${userlist[index].dob}",
                                      //           style: const TextStyle(
                                      //             fontStyle: FontStyle.italic,
                                      //           ),
                                      //         ),
                                      //       ]),
                                      // ),
                                      const SizedBox(height: 4),
                                      // RichText(
                                      //   text: TextSpan(
                                      //       style: DefaultTextStyle.of(context).style,
                                      //       children: [
                                      //         const TextSpan(
                                      //           text: "Gender : ",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //           ),
                                      //         ),
                                      //         TextSpan(
                                      //           text: "${userlist[index].gender}",
                                      //           style: const TextStyle(
                                      //             fontStyle: FontStyle.italic,
                                      //           ),
                                      //         ),
                                      //       ]),
                                      // ),
                                      const SizedBox(height: 4),
                                      // RichText(
                                      //   text: TextSpan(
                                      //       style: DefaultTextStyle.of(context).style,
                                      //       children: [
                                      //         const TextSpan(
                                      //           text: "Address : ",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //           ),
                                      //         ),
                                      //         TextSpan(
                                      //           text: "${userlist[index].address}",
                                      //           style: const TextStyle(
                                      //             fontStyle: FontStyle.italic,
                                      //           ),
                                      //         ),
                                      //       ]),
                                      // ),

                                      // Text("Last Name: ${userlist[index].lname}"),
                                      // const SizedBox(height: 4),
                                      // Text("Email: ${userlist[index].email}"),
                                      // const SizedBox(height: 4),
                                      // Text("Mobile: ${userlist[index].mobile}"),
                                      // const SizedBox(height: 4),
                                      // Text("CNIC: ${userlist[index].cnic}"),
                                      // const SizedBox(height: 4),
                                      // Text("Date Of Birth: ${userlist[index].dob}"),
                                      // const SizedBox(height: 4),
                                      // Text("Gender: ${userlist[index].gender}"),
                                      // const SizedBox(height: 4),
                                      // Text("Address: ${userlist[index].address}"),
                                      // const SizedBox(height: 4),
                                      const Center(
                                        child: SizedBox(
                                            // width: 200,
                                            // child: ElevatedButton(
                                            //     onPressed: () {
                                            //       Navigator.push(
                                            //           context,
                                            //           MaterialPageRoute(
                                            //               builder: (context) =>
                                            //                   JobApplicationDetail(
                                            //                     uid: widget.uid,
                                            //                     applicationid:
                                            //                         fetchleaveapplication[
                                            //                                 index]
                                            //                             .jid,
                                            //                   )));
                                            //     },
                                            //     child: Text("Detail")),
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<List<Leavewithusermodel2>> fetchleaveapplication(int id) async {
    //response keyword khud sa bnaya ha
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Leave/NewPendingLeaveGet?uid=$id')); // is ma aik variable bnaya ha response ka name sa or phir get method ka through api ko hit kar rahay hn is ka data aik data variable ma store karway ga
    var Data = jsonDecode(response.body
        .toString()); // decode kar ka data variable ma store kar rahay hn
    if (response.statusCode == 200) {
      laveapplicationlist.clear();

      if (Data is Map<String, dynamic>) {
        laveapplicationlist.add(Leavewithusermodel2.fromJson(Data));
      } else if (Data is List) {
        for (Map<String, dynamic> index in Data) {
          laveapplicationlist.add(Leavewithusermodel2.fromJson(index));
        }
      }
      return laveapplicationlist;
    } else {
      return laveapplicationlist;
    }
  }
}
