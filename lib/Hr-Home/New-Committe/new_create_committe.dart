import 'package:flutter/material.dart';
import 'package:hrm_final_project/Hr-Home/New-Committe/all_employess.dart';
import 'package:hrm_final_project/Models/committe_model.dart';
import 'package:hrm_final_project/uri.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Models/committee_with_member_for_employ_Model2.dart';

class NewCreateCommitte extends StatefulWidget {
  int? uid;
  int? comid;

  NewCreateCommitte({super.key, required this.comid, required this.uid});

  @override
  State<NewCreateCommitte> createState() => _NewCreateCommitteState();
}

class _NewCreateCommitteState extends State<NewCreateCommitte> {
  List<CommitteModel> committelist = [];
  List<Foremployeecommitteewithmember> memberlist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Committe Details"),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              height: 150,

              // decoration: BoxDecoration(color: Colors.grey.shade500),
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder(
                        future: fetchCommitte(widget.comid!),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text('Press button to start.');
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.done:
                              if (snapshot.hasError)
                                return Text('Error: ${snapshot.error}');
                              if (!snapshot.hasData) return Text('No data');
                              return ListView.builder(
                                  itemCount: committelist.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.black)),
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
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.2),
                                                    child: Text(
                                                      " ${committelist[index].committeeTitle}",
                                                      style: const TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: RichText(
                                                      text: TextSpan(
                                                          style: DefaultTextStyle
                                                                  .of(context)
                                                              .style,
                                                          children: [
                                                            const TextSpan(
                                                              text:
                                                                  "Committee Head: ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  "${committelist[index].user!.fname}  ${committelist[index].user!.lname}",
                                                              style: const TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontSize: 18),
                                                            ),
                                                          ]),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.07),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          "Add Committee Members",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            AllEmployeesForCommiitte(
                                                                              committeid: committelist[index].committeeId,
                                                                              uid: widget.uid,
                                                                            )));
                                                              },
                                                              icon: const Icon(
                                                                Icons.add,
                                                                size: 40,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    );
                                  });
                            default:
                              return Text('Unexpected error');
                          }
                        }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.23),
              child: Container(
                // decoration: BoxDecoration(color: Colors.grey.shade800),
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder(
                          future: fetchCommitte(widget.comid!),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Text('Press button to start.');
                              case ConnectionState.active:
                              case ConnectionState.waiting:
                                return const Center(
                                    child: CircularProgressIndicator());
                              case ConnectionState.done:
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                if (!snapshot.hasData) return Text('No data');
                                return GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 0,
                                      crossAxisSpacing: 0,
                                      childAspectRatio: 3 / 3,
                                    ),
                                    itemCount: committelist
                                        .expand((c) => c.committeeMembers!)
                                        .length,
                                    itemBuilder: (context, index) {
                                      var member = committelist
                                          .expand((c) => c.committeeMembers!)
                                          .toList()[index];

                                      return Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        child: Container(
                                            height: 350,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 130),
                                                  child: Stack(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                title: const Text(
                                                                    'Remove member?'),
                                                                content: const Text(
                                                                    'Are you sure you want to Remove This Member'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        'Cancel'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      _deletecommittemember(
                                                                          member
                                                                              .committeeImemberId!);
                                                                    },
                                                                    child: Text(
                                                                        'Remove'),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                          icon: Icon(
                                                            Icons.close,
                                                            color: Colors.red,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.07,
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.00),
                                                  child: Container(
                                                    height: 90,
                                                    child: (member.user!
                                                                    .image !=
                                                                null &&
                                                            member.user!.image!
                                                                .trim()
                                                                .isNotEmpty)
                                                        ? ClipOval(
                                                            child: Image(
                                                              fit: BoxFit.cover,
                                                              height: 100,
                                                              width: 100,
                                                              image: NetworkImage(
                                                                  imagepath +
                                                                      member
                                                                          .user!
                                                                          .image
                                                                          .toString()),
                                                            ),
                                                          )
                                                        : const Icon(
                                                            Icons.person,
                                                            size: 100),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.06),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style:
                                                          DefaultTextStyle.of(
                                                                  context)
                                                              .style,
                                                      children: [
                                                        const TextSpan(
                                                          text: "",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "${member.user!.fname} ${member.user!.lname} ",
                                                          style:
                                                              const TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      );
                                    });

                              default:
                                return Text('Unexpected error');
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2),
              child: Text(
                "Committe Members :",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
  }

  Future<List<CommitteModel>> fetchCommitte(int id) async {
    //response keyword khud sa bnaya ha
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Committee/CommitteeGet?comid=$id')); // is ma aik variable bnaya ha response ka name sa or phir get method ka through api ko hit kar rahay hn is ka data aik data variable ma store karway ga
    var Data = jsonDecode(response.body
        .toString()); // decode kar ka data variable ma store kar rahay hn
    if (response.statusCode == 200) {
      committelist.clear();
      for (Map<String, dynamic> index in Data) {
        committelist.add(CommitteModel.fromJson(index));
      }
      return committelist;
    } else {
      return committelist;
    }
  }

  Future<void> _deletecommittemember(int Id) async {
    final response = await http.delete(
      Uri.parse(
          'http://$ip/HrmPractise02/api/Committeemembers/DeleteCommitteMember?CommitteeImemberId=$Id'),
    );

    if (response.statusCode == 200) {
      // Refresh job list
      setState(() {
        memberlist.removeWhere((job) => job.committeeImemberId == Id);
      });
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete job')),
      );
    }
  }
}
