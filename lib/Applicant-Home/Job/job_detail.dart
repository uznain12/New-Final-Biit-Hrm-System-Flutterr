import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hrm_final_project/Applicant-Home/Job/job_apply.dart';
import 'package:hrm_final_project/Models/job_model.dart';
import 'package:hrm_final_project/uri.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // use for dateformat

// ignore: must_be_immutable
class JobDetailScreen extends StatefulWidget {
  int? uid;
  int? jid;
  JobDetailScreen({required this.uid, required this.jid});
  // const ApplicantApplyJob({super.key});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  List<Jobmodel> jobdetaillist = [];

  String _formatDate(DateTime date) {
    //ya date ko sai sa show karwanay ka liya bnaya ha like is format ma show hogi date
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // ignore: unused_field
  late Widget _widget;
  @override
  void initState() {
    super.initState();
    _widget = JobDetailScreen(
      uid: widget.uid,
      jid: widget.jid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Job Detail',
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
              future: getjobdetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: jobdetaillist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.width * 0.02,
                                right: MediaQuery.of(context).size.width * 0.02,
                              ),
                              child: Container(
                                height: 500,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02,
                                    top: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text: "Job  Title :  ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${jobdetaillist[index].title}",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ]),
                                      ),

                                      const SizedBox(height: 6),
                                      RichText(
                                        text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text: "Qualification:  ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${jobdetaillist[index].qualification}",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ]),
                                      ),

                                      const SizedBox(height: 6),
                                      RichText(
                                        text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text: "Vacancies:  ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${jobdetaillist[index].noofvacancie}",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ]),
                                      ),

                                      const SizedBox(height: 6),
                                      RichText(
                                        text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text: "Salary :        ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${jobdetaillist[index].salary}",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      // Text(
                                      //   "Title: ${jobdetaillist[index].title}",
                                      //   style: const TextStyle(
                                      //     fontSize: 17,
                                      //     fontWeight: FontWeight.w900,
                                      //   ),
                                      // ),
                                      const SizedBox(height: 6),
                                      // Text(
                                      //   "Salary:${jobdetaillist[index].salary.toString()}",
                                      //   style: const TextStyle(
                                      //     fontSize: 17,
                                      //     fontWeight: FontWeight.w900,
                                      //   ),
                                      // ),
                                      RichText(
                                        text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text: "Location :    ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${jobdetaillist[index].location}",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      const SizedBox(height: 6),
                                      // Text(
                                      //   "Location:   ${jobdetaillist[index].location}",
                                      //   style: TextStyle(
                                      //     fontSize: 17,
                                      //     fontWeight: FontWeight.w900,
                                      //   ),
                                      // ),
                                      RichText(
                                        text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text: "Last Date:    ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              TextSpan(
                                                text: _formatDate(
                                                    DateTime.parse(
                                                        jobdetaillist[index]
                                                            .lastDateOfApply
                                                            .toString())),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      const SizedBox(height: 6),

                                      RichText(
                                        text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text: "Description: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${jobdetaillist[index].description}",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ]),
                                      ),

                                      const SizedBox(height: 4),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2),
                                        child: SizedBox(
                                          width: 200,
                                          height: 50,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ApplyJobApplicant(
                                                              uid: widget.uid,
                                                              jid:
                                                                  jobdetaillist[
                                                                          index]
                                                                      .jid,
                                                            )));
                                              },
                                              child: const Text(
                                                "Apply",
                                                style: TextStyle(
                                                    fontFamily:
                                                        'RobotoSlab-Black',
                                                    fontSize: 18),
                                              )),
                                        ),
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
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        )),
      ),
    );
  }

  Future<List<Jobmodel>> getjobdetails() async {
    //response keyword khud sa bnaya ha
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Job/NewJobdetailGet?uid=${widget.uid}&Jid=${widget.jid}')); // is ma aik variable bnaya ha response ka name sa or phir get method ka through api ko hit kar rahay hn is ka data aik data variable ma store karway ga
    var Data = jsonDecode(response.body
        .toString()); // decode kar ka data variable ma store kar rahay hn
    if (response.statusCode == 200) {
      jobdetaillist.clear();
      if (Data is Map<String, dynamic>) {
        jobdetaillist.add(Jobmodel.fromJson(Data));
      } else if (Data is List) {
        for (Map<String, dynamic> index in Data) {
          jobdetaillist.add(Jobmodel.fromJson(index));
        }
      }
      return jobdetaillist;
    } else {
      return jobdetaillist;
    }
  }
}
