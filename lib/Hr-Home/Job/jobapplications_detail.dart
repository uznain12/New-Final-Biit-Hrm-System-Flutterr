import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hrm_final_project/Models/job_application_model_hr.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class JobApplicationDetail extends StatefulWidget {
  int? uid;
  int? applicationid;
  JobApplicationDetail({required this.uid, required this.applicationid});
  // const ApplicantApplyJob({super.key});

  @override
  State<JobApplicationDetail> createState() => _JobApplicationDetailState();
}

class _JobApplicationDetailState extends State<JobApplicationDetail> {
  List<JobApplicationModel> Jobapplicationdetaillist = [];
  @override
  void initState() {
    super.initState();
  }

  // void downloadFile(String documentPath) async {
  //   if (documentPath.isNotEmpty) {
  //     final file = File(documentPath);
  //     if (await file.exists()) {
  //       final bytes = await file.readAsBytes();
  //       final dir = await getExternalStorageDirectory();
  //       final filePath = '${dir!.path}/cv.pdf';
  //       final newFile = File(filePath);
  //       await newFile.writeAsBytes(bytes);
  //       // Now the PDF file is downloaded and saved as 'cv.pdf' in the device's storage.
  //     } else {
  //       print('File does not exist');
  //     }
  //   }
  // }

  void downloadFile(String filepath) async {
    if (filepath.isNotEmpty) {
      final file = File(filepath);
      if (await file.exists()) {
        final bytes = await file.readAsBytes();
        final directory = await getApplicationDocumentsDirectory();
        final destinationPath = '${directory.path}/cv.pdf';
        await File(destinationPath).writeAsBytes(bytes);
        print(
            'File downloaded and saved as "cv.pdf" in the device\'s storage.');
      } else {
        print('File does not exist: $filepath');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Applicant Details',
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2, color: Colors.black)),
        child: SingleChildScrollView(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
              future: Jobapplicationsdetail(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: Jobapplicationdetaillist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.width * 0.02,
                                right: MediaQuery.of(context).size.width * 0.02,
                              ),
                              child: Container(
                                height: 1000,
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
                                      const SizedBox(height: 4),
                                      RichText(
                                        text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text:
                                                    "Job Title :                 ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${Jobapplicationdetaillist[index].job.title}",
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: [
                                            const TextSpan(
                                              text: "CV :                 ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "Download CV",
                                              style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.blue,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  downloadFile(
                                                      Jobapplicationdetaillist[
                                                              index]
                                                          .DocumentPath);
                                                },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Center(
                                          child: Text(
                                        "Applicatn Persoanl Information",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      )),
                                      const SizedBox(height: 4),
                                      RichText(
                                        text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text: "Name :            ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${Jobapplicationdetaillist[index].user!.fname} "
                                                    " ${Jobapplicationdetaillist[index].user!.lname}",
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      const SizedBox(height: 4),
                                      RichText(
                                        text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text: "Email:              ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${Jobapplicationdetaillist[index].user!.email}",
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      const SizedBox(height: 4),
                                      RichText(
                                        text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text: "Gender:           ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${Jobapplicationdetaillist[index].user!.gender}",
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      const SizedBox(height: 4),
                                      RichText(
                                        text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text: "Conatct:          ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${Jobapplicationdetaillist[index].user!.mobile}",
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      const SizedBox(height: 4),
                                      RichText(
                                        text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text: "DOB:                ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${Jobapplicationdetaillist[index].user!.dob}",
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      const SizedBox(height: 4),
                                      RichText(
                                        text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text: "Address:         ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${Jobapplicationdetaillist[index].user!.address}",
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      const SizedBox(height: 10),
                                      const Center(
                                          child: Text(
                                        "Applicatn Educational Information",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      )),
                                      const SizedBox(height: 4),
                                      const SizedBox(height: 4),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            Jobapplicationdetaillist[index]
                                                .user!
                                                .educations
                                                .length,
                                        itemBuilder: (BuildContext context,
                                            int educationIndex) {
                                          final education =
                                              Jobapplicationdetaillist[index]
                                                  .user!
                                                  .educations[educationIndex];
                                          return Column(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text:
                                                            "Degree:         ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: Jobapplicationdetaillist[
                                                                    index]
                                                                .user!
                                                                .educations
                                                                .isNotEmpty
                                                            ? "${Jobapplicationdetaillist[index].user!.educations[0].degree}"
                                                            : "Not provided",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              const SizedBox(height: 4),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text:
                                                            "Institute:         ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: Jobapplicationdetaillist[
                                                                    index]
                                                                .user!
                                                                .educations
                                                                .isNotEmpty
                                                            ? "${Jobapplicationdetaillist[index].user!.educations[0].institute}"
                                                            : "Not provided",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              const SizedBox(height: 4),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text: "Board:         ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: Jobapplicationdetaillist[
                                                                    index]
                                                                .user!
                                                                .educations
                                                                .isNotEmpty
                                                            ? "${Jobapplicationdetaillist[index].user!.educations[0].board}"
                                                            : "Not provided",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              const SizedBox(height: 4),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text:
                                                            "start date:         ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: Jobapplicationdetaillist[
                                                                    index]
                                                                .user!
                                                                .educations
                                                                .isNotEmpty
                                                            ? "${Jobapplicationdetaillist[index].user!.educations[0].startdate}"
                                                            : "Not provided",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              const SizedBox(height: 4),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text:
                                                            "End Date:         ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: Jobapplicationdetaillist[
                                                                    index]
                                                                .user!
                                                                .educations
                                                                .isNotEmpty
                                                            ? "${Jobapplicationdetaillist[index].user!.educations[0].enddate}"
                                                            : "Not provided",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              const Text(
                                                  "--------------------------------------------------------------------------------"),
                                              // Add more fields as required for education details
                                              const SizedBox(height: 10),
                                            ],
                                          );
                                        },
                                      ),
                                      const Center(
                                        child: Text(
                                          "Applicant Previous Experience",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            Jobapplicationdetaillist[index]
                                                .user!
                                                .experiences
                                                .length,
                                        itemBuilder: (BuildContext context,
                                            int experienceIndex) {
                                          final experience =
                                              Jobapplicationdetaillist[index]
                                                  .user!
                                                  .experiences[experienceIndex];
                                          return Column(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text:
                                                            "Company:         ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: Jobapplicationdetaillist[
                                                                    index]
                                                                .user!
                                                                .experiences
                                                                .isNotEmpty
                                                            ? "${Jobapplicationdetaillist[index].user!.experiences[0].company}"
                                                            : "Not provided",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              const SizedBox(height: 4),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text: "Title:         ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: Jobapplicationdetaillist[
                                                                    index]
                                                                .user!
                                                                .experiences
                                                                .isNotEmpty
                                                            ? "${Jobapplicationdetaillist[index].user!.experiences[0].title}"
                                                            : "Not provided",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              const SizedBox(height: 4),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text:
                                                            "Start Date:         ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: Jobapplicationdetaillist[
                                                                    index]
                                                                .user!
                                                                .experiences
                                                                .isNotEmpty
                                                            ? "${Jobapplicationdetaillist[index].user!.experiences[0].startdate}"
                                                            : "Not provided",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              const SizedBox(height: 4),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text:
                                                            " Till Now:         ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: Jobapplicationdetaillist[
                                                                    index]
                                                                .user!
                                                                .experiences
                                                                .isNotEmpty
                                                            ? "${Jobapplicationdetaillist[index].user!.experiences[0].currentwork}"
                                                            : "Not provided",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              const SizedBox(height: 4),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text:
                                                            "End Date:         ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: Jobapplicationdetaillist[
                                                                    index]
                                                                .user!
                                                                .experiences
                                                                .isNotEmpty
                                                            ? "${Jobapplicationdetaillist[index].user!.experiences[0].enddate}"
                                                            : "Not provided",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              const SizedBox(height: 4),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text:
                                                            "Other Skills:         ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: Jobapplicationdetaillist[
                                                                    index]
                                                                .user!
                                                                .experiences
                                                                .isNotEmpty
                                                            ? "${Jobapplicationdetaillist[index].user!.experiences[0].otherskill}"
                                                            : "Not provided",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              const Text(
                                                  "--------------------------------------------------------------------------------"),
                                              // Add more fields as required for experience details
                                              const SizedBox(height: 10),
                                            ],
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                        ),
                                        child: SizedBox(
                                          width: 200,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              shortlist();
                                            },
                                            child: const Text(
                                              "Short List",
                                              style: TextStyle(
                                                fontFamily: 'RobotoSlab-Black',
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
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
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        )),
      ),
    );
  }

  Future<List<JobApplicationModel>> Jobapplicationsdetail() async {
    //response keyword khud sa bnaya ha
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/JobApplication/JobApplicationHrSideGet?applicationid=${widget.applicationid}')); // is ma aik variable bnaya ha response ka name sa or phir get method ka through api ko hit kar rahay hn is ka data aik data variable ma store karway ga
    var Data = jsonDecode(response.body
        .toString()); // decode kar ka data variable ma store kar rahay hn
    if (response.statusCode == 200) {
      Jobapplicationdetaillist.clear();
      for (Map<String, dynamic> index in Data) {
        Jobapplicationdetaillist.add(JobApplicationModel.fromJson(index));
      }
      return Jobapplicationdetaillist;
    } else {
      return Jobapplicationdetaillist;
    }
  }

  void shortlist() async {
    var url = "http://$ip/HrmPractise02/api/Shortlist/SHortlistPost";
    var data = {
      "Uid": widget.uid,
      "ApplicationID": widget.applicationid,
    };
    var boddy = jsonEncode(data);
    var urlParse = Uri.parse(url);
    try {
      http.Response response = await http.post(urlParse,
          body: boddy, headers: {"Content-Type": "application/json"});
      var dataa = jsonDecode(response.body);
      print(dataa);
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
