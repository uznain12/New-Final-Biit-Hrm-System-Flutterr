import 'package:flutter/material.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_approved_leaves.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_leave_applications.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_rejected_leaves.dart';
import 'package:hrm_final_project/Hr-Home/Leave/leave_detail_action.dart';
import 'package:hrm_final_project/Models/leave_and_user_model.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class AllPendingLeave extends StatefulWidget {
  const AllPendingLeave({
    super.key,
  });

  @override
  State<AllPendingLeave> createState() => _AllPendingLeaveState();
}

class _AllPendingLeaveState extends State<AllPendingLeave> {
  List<Leavewithusermodel> laveapplicationlist = [];
  String _formatDate(DateTime date) {
    //ya date ko sai sa show karwanay ka liya bnaya ha like is format ma show hogi date
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pending Applications"),
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
                                    builder: (context) =>
                                        AllLeaveApplications()));
                            // button press code here
                          },
                          child: const Text('All'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllAprovedLeave()));
                            // button press code here
                          },
                          child: const Text('Approved'),
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
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
                                  left:
                                      MediaQuery.of(context).size.height * 0.01,
                                  right: MediaQuery.of(context).size.height *
                                      0.01),
                              child: Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade300,
                                  border:
                                      Border.all(width: 5, color: Colors.black),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.pink.shade50,
                                      Colors.blue.shade100
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.03),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                                  text:
                                                      "Leave Type:              ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      // ignore: unnecessary_string_interpolations
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
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<List<Leavewithusermodel>> fetchleaveapplication() async {
    //response keyword khud sa bnaya ha
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Leave/AllNewPendingLeaveGet')); // is ma aik variable bnaya ha response ka name sa or phir get method ka through api ko hit kar rahay hn is ka data aik data variable ma store karway ga
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
