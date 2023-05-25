import 'package:flutter/material.dart';
import 'package:hrm_final_project/Hr-Home/New-Committe/all_head.dart';
import 'package:hrm_final_project/Hr-Home/New-Committe/new_create_committe.dart';
import 'package:hrm_final_project/Models/committe_model.dart';
import 'package:hrm_final_project/uri.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MainCommittePage extends StatefulWidget {
  int? uid;
  MainCommittePage({
    super.key,
    required this.uid,
  });

  @override
  State<MainCommittePage> createState() => _MainCommittePageState();
}

class _MainCommittePageState extends State<MainCommittePage> {
  List<CommitteModel> committelist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Committe Home"),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            FutureBuilder(
                future: getcommitte(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: committelist.length,
                        itemBuilder: (context, index) {
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
                                        builder: (context) => NewCreateCommitte(
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
                                                          fontStyle:
                                                              FontStyle.italic,
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
                                                        'Delete Committee?'),
                                                    content: const Text(
                                                        'Are you sure you want to delete this Committee?'),
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
                                                          _deletecommitte(
                                                              committelist[
                                                                      index]
                                                                  .committeeId!);
                                                        },
                                                        child: Text('Delete'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.delete,
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

  Future<void> _deletecommitte(int Id) async {
    final response = await http.delete(
      Uri.parse(
          'http://$ip/HrmPractise02/api/Committee/DeleteCommitte?CommitteeId=$Id'),
    );

    if (response.statusCode == 200) {
      // Refresh job list
      setState(() {
        committelist.removeWhere((job) => job.committeeId == Id);
      });
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete job')),
      );
    }
  }
}
