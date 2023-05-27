import 'package:flutter/material.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_leave_applications.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_pending_leaves.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_rejected_leaves.dart';
import 'package:hrm_final_project/Models/leave_and_user_model.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class AllAprovedLeave extends StatefulWidget {
  AllAprovedLeave({
    super.key,
  });

  @override
  State<AllAprovedLeave> createState() => _AllAprovedLeaveState();
}

class _AllAprovedLeaveState extends State<AllAprovedLeave> {
  List<Leavewithusermodel> laveapplicationlist = [];
  String _formatDate(DateTime date) {
    //ya date ko sai sa show karwanay ka liya bnaya ha like is format ma show hogi date
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // ignore: unused_field
  late Widget _widget;
  @override
  void initState() {
    super.initState();
    _widget = AllAprovedLeave();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Leave Applications"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: fetchleaveapplication(),
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
                                    builder: (context) => AllPendingLeave()));
                            // button press code here
                          },
                          child: Text('Pending'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AllLeaveApplications()));
                            // button press code here
                          },
                          child: Text('All'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllRejectedLeaves()));
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
                                                      "${laveapplicationlist[index].leavetype}",
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
                                                  text: laveapplicationlist[
                                                                  index]
                                                              .applydate ==
                                                          null
                                                      ? 'No Date Provided'
                                                      : _formatDate(
                                                          DateTime.parse(
                                                              laveapplicationlist[
                                                                      index]
                                                                  .applydate
                                                                  .toString())),
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
                                                      "${laveapplicationlist[index].status} ",
                                                  style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      const SizedBox(height: 4),

                                      const SizedBox(height: 4),

                                      const SizedBox(height: 4),
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

  Future<List<Leavewithusermodel>> fetchleaveapplication() async {
    //response keyword khud sa bnaya ha
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Leave/AllNewApprovedLeaveGet')); // is ma aik variable bnaya ha response ka name sa or phir get method ka through api ko hit kar rahay hn is ka data aik data variable ma store karway ga
    // ignore: non_constant_identifier_names
    var Data = jsonDecode(response.body
        .toString()); // decode kar ka data variable ma store kar rahay hn
    if (response.statusCode == 200) {
      laveapplicationlist.clear();
      for (Map<String, dynamic> index in Data) {
        laveapplicationlist.add(Leavewithusermodel.fromJson(index));
      }
      return laveapplicationlist;
    } else {
      return laveapplicationlist;
    }
  }
}
