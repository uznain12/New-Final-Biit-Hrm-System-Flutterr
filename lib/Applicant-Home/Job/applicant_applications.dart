import 'package:flutter/material.dart';
import 'package:hrm_final_project/Models/job_and_jobapplication_model.dart';
import 'package:hrm_final_project/uri.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class ApplicantApplications extends StatefulWidget {
  int? uid;
  ApplicantApplications({super.key, required this.uid});

  @override
  State<ApplicantApplications> createState() => _ApplicantApplicationsState();
}

class _ApplicantApplicationsState extends State<ApplicantApplications> {
  List<JobandJobapplicationmodel> jobapplicationlist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Job Applications"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: fetchcuser(widget.uid!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: jobapplicationlist.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02,
                            left: MediaQuery.of(context).size.width * 0.03,
                            right: MediaQuery.of(context).size.width * 0.03),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            border: Border.all(width: 4, color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.1),
                                  child: RichText(
                                    text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: [
                                          const TextSpan(
                                            text: "Job Name :     ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                "${jobapplicationlist[index].jobTitle}",
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
                                      left: MediaQuery.of(context).size.width *
                                          0.1),
                                  child: RichText(
                                    text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: [
                                          const TextSpan(
                                            text: "Status :            ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                "${jobapplicationlist[index].status} ",
                                            style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.green),
                                          ),
                                        ]),
                                  ),
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          ),
                        ),
                      );
                    }));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<List<JobandJobapplicationmodel>> fetchcuser(int id) async {
    //response keyword khud sa bnaya ha
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/JobApplication/JoinJobApplicationwithidGet?appid=$id')); // is ma aik variable bnaya ha response ka name sa or phir get method ka through api ko hit kar rahay hn is ka data aik data variable ma store karway ga
    var Data = jsonDecode(response.body
        .toString()); // decode kar ka data variable ma store kar rahay hn
    if (response.statusCode == 200) {
      jobapplicationlist.clear();
      if (Data is Map<String, dynamic>) {
        jobapplicationlist.add(JobandJobapplicationmodel.fromJson(Data));
      } else if (Data is List) {
        for (Map<String, dynamic> index in Data) {
          jobapplicationlist.add(JobandJobapplicationmodel.fromJson(index));
        }
      }
      return jobapplicationlist;
    } else {
      return jobapplicationlist;
    }
  }
}
