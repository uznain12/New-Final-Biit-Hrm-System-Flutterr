// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hrm_final_project/Hr-Home/New-Committe/all_head.dart';
import 'package:hrm_final_project/Hr-Home/New-Committe/new_create_committe.dart';
import 'package:hrm_final_project/Models/committe_model.dart';
import 'package:hrm_final_project/uri.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AssignJobToCommittee extends StatefulWidget {
  int? uid;
  int? jobappid;
  AssignJobToCommittee({super.key, required this.uid, required this.jobappid});

  @override
  State<AssignJobToCommittee> createState() => _AssignJobToCommitteeState();
}

class _AssignJobToCommitteeState extends State<AssignJobToCommittee> {
  List<CommitteModel> committelist = [];
  Map<int, bool> committeeAssignSuccess = Map<int,
      bool>(); // Ya is liya bnaya ha ka jab committee ko job assign ho jay to tick jo ha done ma change ho jay or isko hum na upload ka function ma use kiya ha or icon button ka icon ma sirf 2 jagha ya use huva ha

  late Future<List<CommitteModel>>
      _futureCommitteeList; // this is for refresh the screen means refresh functionality

  @override
  void initState() {
    super.initState();
    _futureCommitteeList = getcommitte();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Committe Home"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _futureCommitteeList = getcommitte();
                });
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _futureCommitteeList = getcommitte();
                });
              },
              child: FutureBuilder(
                  future: getcommitte(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: committelist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.02,
                                  left:
                                      MediaQuery.of(context).size.width * 0.02,
                                  right:
                                      MediaQuery.of(context).size.width * 0.02),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewCreateCommitte(
                                                uid: widget.uid,
                                                comid: committelist[index]
                                                    .committeeId,
                                              )));
                                },
                                child: Container(
                                    height: 80,
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
                                                        text: "Committee :  ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${committelist[index].committeeTitle}",
                                                        style: const TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 18),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 8),
                                              child: IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: const Text(
                                                          'Assign Job?'),
                                                      content: const Text(
                                                          'Are you sure you want to Assign To  this Committee?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            Addtocommitteeapplications(
                                                                committelist[
                                                                        index]
                                                                    .committeeId!);
                                                          },
                                                          child: Text('Yes'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                icon: committeeAssignSuccess[
                                                            committelist[index]
                                                                .committeeId] ==
                                                        true
                                                    ? const Icon(
                                                        Icons
                                                            .check_circle, // change this to the icon you want to display on success
                                                        size: 30,
                                                        color: Colors
                                                            .green, // and this to the color you want to display on success
                                                      )
                                                    : const Icon(
                                                        Icons.check,
                                                        size: 30,
                                                        color: Colors.redAccent,
                                                      ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            );
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.72,
                  left: MediaQuery.of(context).size.width * 0.8),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllHeadsForCommiitte(
                                  uid: widget.uid,
                                )));
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 60,
                  )),
            ),
          ],
        ));
  }

  Future<List<CommitteModel>> getcommitte() async {
    // Get the current user's UID.
    final response = await http.get(
        Uri.parse('http://$ip/HrmPractise02/api/Committee/AllCommitteeGet'));
    var Data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      committelist.clear();
      for (Map<String, dynamic> index in Data) {
        committelist.add(CommitteModel.fromJson(index));
      }
    } else {
      print(
          'Error occurred: ${response.statusCode} - ${response.body}'); // print the error
    }
    return committelist;
  }

  void Addtocommitteeapplications(int committeeId) async {
    var url =
        "http://$ip/HrmPractise02/api/Assignjobapplication/AssinJobApplicationToCommittee2";
    var data = {
      "JobApplicationID": widget.jobappid,
      "CommitteeId": committeeId
    };
    var boddy = jsonEncode(data);
    var urlParse = Uri.parse(url);
    try {
      http.Response response = await http.post(urlParse,
          body: boddy, headers: {"Content-Type": "application/json"});
      var dataa = jsonDecode(response.body);
      print(dataa);
      if (response.statusCode == 200) {
        // or whatever condition you want to check for success
        setState(() {
          committeeAssignSuccess[committeeId] =
              true; //ya jo uper map bnaya icon change karnay ka liya wo use huva ha
        });
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
