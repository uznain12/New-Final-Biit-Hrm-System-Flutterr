import 'package:flutter/material.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_approved_leaves.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_pending_leaves.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_rejected_leaves.dart';
import 'package:hrm_final_project/Hr-Home/Leave/leave_detail_action.dart';
import 'package:hrm_final_project/Models/leave_and_user_model.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllLeaveApplications extends StatefulWidget {
  const AllLeaveApplications({
    super.key,
  });

  @override
  State<AllLeaveApplications> createState() => _AllLeaveApplicationsState();
}

class _AllLeaveApplicationsState extends State<AllLeaveApplications> {
  List<Leavewithusermodel> laveapplicationlist = [];

  // ignore: unused_field
  late Widget _widget;
  @override
  void initState() {
    super.initState();
    _widget = AllLeaveApplications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Leave Applications"),
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
                          child: Text('pending'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllAprovedLeave()));
                            // button press code here
                          },
                          child: Text('Approved'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllRejectedLeaves()));
                            // button press code here
                          },
                          child: const Text('Rejected'),
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
                                                  text: "Applicant Name :    ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${laveapplicationlist[index].fname} ${laveapplicationlist[index].lname} ",
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
                                                      "${laveapplicationlist[index].leavetype}",
                                                  style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

                                      Center(
                                        child: SizedBox(
                                          width: 200,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LeaveDetailPlusAction(
                                                              uid:
                                                                  laveapplicationlist[
                                                                          index]
                                                                      .uid,
                                                              reson:
                                                                  laveapplicationlist[
                                                                          index]
                                                                      .reason,
                                                              leavetype:
                                                                  laveapplicationlist[
                                                                          index]
                                                                      .leavetype,
                                                              sdate:
                                                                  laveapplicationlist[
                                                                          index]
                                                                      .startdate,
                                                              edate:
                                                                  laveapplicationlist[
                                                                          index]
                                                                      .enddate,
                                                              apdate:
                                                                  laveapplicationlist[
                                                                          index]
                                                                      .applydate,
                                                              leavid:
                                                                  laveapplicationlist[
                                                                          index]
                                                                      .leaveappid,
                                                            )));
                                              },
                                              child: Text("Detail")),
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

  Future<List<Leavewithusermodel>> fetchleaveapplication() async {
    //response keyword khud sa bnaya ha
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Leave/NewAllLeaveapplicationGet')); // is ma aik variable bnaya ha response ka name sa or phir get method ka through api ko hit kar rahay hn is ka data aik data variable ma store karway ga
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
