// ignore_for_file: must_be_immutable, avoid_print, unused_field

import 'package:flutter/material.dart';
import 'package:hrm_final_project/Hr-Home/New-Committe/new_create_committe.dart';
import 'package:hrm_final_project/Models/committe_model.dart';
import 'package:hrm_final_project/uri.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AssignJobToCommittee extends StatefulWidget {
  int? uid;
  final List<int>? useruid;
  final List<int>? jobappid;
  final List<int>? jid;
  final List<String>? docupath;

  AssignJobToCommittee(
      {super.key,
      required this.useruid,
      required this.uid,
      required this.jobappid,
      required this.jid,
      required this.docupath});

  @override
  State<AssignJobToCommittee> createState() => _AssignJobToCommitteeState();
}

class _AssignJobToCommitteeState extends State<AssignJobToCommittee> {
  List<CommitteModel> committelist = [];
  Map<int, bool> committeeAssignSuccess = <int,
      bool>{}; // Ya is liya bnaya ha ka jab committee ko job assign ho jay to tick jo ha done ma change ho jay or isko hum na upload ka function ma use kiya ha or icon button ka icon ma sirf 2 jagha ya use huva ha

  late Future<List<CommitteModel>>
      _futureCommitteeList; // this is for refresh the screen means refresh functionality
  @override
  void initState() {
    super.initState();
    if (widget.jobappid == null) {
      print("jobappid is null");
      // Handle the case when jobappid is null
    } else {
      print("jobappid is not null");
      print("jobappid: ${widget.jobappid}");
      // Handle the case when jobappid is not null
    }
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
                                                            UpdateJobapplication();
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
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 200),
                child: ElevatedButton(
                  onPressed: widget.jobappid != null
                      ? () {
                          UpdateJobapplication();
                        }
                      : null, // Add null check for jobappid
                  child: Text("Update"),
                ))
          ],
        ));
  }

  Future<List<CommitteModel>> getcommitte() async {
    // Get the current user's UID.
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Committee/AllCommitteeGet?JobApplicationID=${widget.jobappid}&Jid=${widget.jid}&Uid=${widget.useruid}'));
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

    if (widget.jobappid != null) {
      for (int jobApplicationId in widget.jobappid!) {
        var data = {
          "JobApplicationID": jobApplicationId,
          "CommitteeId": committeeId
        };
        var boddy = jsonEncode(data);
        var urlParse = Uri.parse(url);

        try {
          http.Response response = await http.post(
            urlParse,
            body: boddy,
            headers: {"Content-Type": "application/json"},
          );

          var dataa = jsonDecode(response.body);
          print(dataa);

          if (response.statusCode == 200) {
            setState(() {
              committeeAssignSuccess[committeeId] = true;
            });
          }
        } catch (e) {
          print('Error occurred: $e');
        }
      }
    }
  }

  // void UpdateJobapplication() async {
  //   var url =
  //       "http://$ip/HrmPractise02/api/JobApplication/NewUpdateJobFileApplication";

  //   if (widget.jobappid != null && widget.jid != null) {
  //     assert(widget.jobappid!.length == widget.jid!.length);

  //     List<Map<String, dynamic>> requestData = [];
  //     for (int i = 0; i < widget.jobappid!.length; i++) {
  //       if (widget.jobappid![i] != null && widget.jid![i] != null) {
  //         Map<String, dynamic> data = {
  //           "JobApplicationID": widget.jobappid![i],
  //           "Uid": widget.uid,
  //           "Jid": widget.jid![i],
  //           "status": 'assign',
  //         };
  //         requestData.add(data);
  //       }
  //     }

  //     if (requestData.isNotEmpty) {
  //       var boddy = jsonEncode(requestData);
  //       var urlParse = Uri.parse(url);

  //       try {
  //         http.Response response = await http.put(
  //           urlParse,
  //           body: boddy,
  //           headers: {"Content-Type": "application/json"},
  //         );

  //         var dataa = jsonDecode(response.body);
  //         print(dataa);
  //       } catch (e) {
  //         print('Error occurred: $e');
  //       }
  //     }
  //   }
  // }
  void UpdateJobapplication() async {
    var url =
        "http://$ip/HrmPractise02/api/JobApplication/UpdateJobapplication";

    if (widget.jobappid != null &&
        widget.useruid != null &&
        widget.jid != null) {
      assert(
        widget.jobappid!.length == widget.useruid!.length &&
            widget.jobappid!.length == widget.jid!.length,
      );

      List<Map<String, dynamic>> requestData = [];
      for (int i = 0; i < widget.jobappid!.length; i++) {
        if (widget.jobappid![i] != null &&
            widget.useruid![i] != null &&
            widget.jid![i] != null) {
          Map<String, dynamic> data = {
            "JobApplicationID": widget.jobappid![i],
            "Uid": widget.useruid![i],
            "Jid": widget.jid![i],
            "status": 'assign',
          };
          requestData.add(data);
        }
      }

      if (requestData.isNotEmpty) {
        var boddy = jsonEncode(requestData);
        var urlParse = Uri.parse(url);

        try {
          http.Response response = await http.put(
            urlParse,
            body: boddy,
            headers: {"Content-Type": "application/json"},
          );

          var dataa = jsonDecode(response.body);
          print(dataa);
        } catch (e) {
          print('Error occurred: $e');
        }
      }
    }
  }
}
