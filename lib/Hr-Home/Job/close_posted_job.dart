import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrm_final_project/Models/job_model.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class CloseJobScreen extends StatefulWidget {
  int? jobid;
  String? title;
  String? qualification;
  String? Salary;
  String? experience;
  DateTime? LastDateOfApply;
  String? Location;
  String? Description;
  int? noofvacancie;
  CloseJobScreen(
      {required this.jobid,
      required this.title,
      required this.qualification,
      required this.Salary,
      required this.experience,
      required this.LastDateOfApply,
      required this.Location,
      required this.Description,
      required this.noofvacancie});
  // const ApplicantApplyJob({super.key});

  @override
  State<CloseJobScreen> createState() => _CloseJobScreenState();
}

class _CloseJobScreenState extends State<CloseJobScreen> {
  List<Jobmodel> joblist = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Close Job',
          style: TextStyle(
              fontFamily: 'RobotoSlab-Black',
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w900),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
              future: getjob(widget.jobid!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing:
                                10.0, // Decreased from MediaQuery.of(context).size.height * 0.09
                            crossAxisSpacing:
                                1.0, // Decreased from MediaQuery.of(context).size.width * 0.09
                            childAspectRatio: 3 / 3,
                          ),
                          itemCount: joblist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.2,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.0,
                                left: MediaQuery.of(context).size.width * 0.02,
                                right: MediaQuery.of(context).size.width * 0.02,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.blue,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                          0.2), // Shadow color with reduced opacity
                                      offset: Offset(0,
                                          3), // Horizontal and vertical offset of the shadow
                                      blurRadius:
                                          6, // Amount of blur applied to the shadow
                                      spreadRadius:
                                          2, // Extent of the shadow, a higher value will make the shadow larger
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: Text(
                                        "Are You Sure To Close This Job?",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.28),
                                      child: Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Closejob();
                                              },
                                              child: Text("YES")),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("No"))
                                        ],
                                      ),
                                    )
                                  ],
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

  Future<List<Jobmodel>> getjob(
    int id,
  ) async {
    // Get the current user's UID.
    final response = await http.get(
        Uri.parse('http://$ip/HrmPractise02/api/Job/NewJobWithIdGet?jid=$id'));
    var Data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      joblist.clear();
      for (Map<String, dynamic> index in Data) {
        joblist.add(Jobmodel.fromJson(index));
      }
    } else {
      print(
          'Error occurred: ${response.statusCode} - ${response.body}'); // print the error
    }
    return joblist;
  }

  void Closejob() async {
    var url = "http://$ip/HrmPractise02/api/Job/UpdateJob";
    var data = {
      "Jid": widget.jobid,
      "Title": widget.title,
      "qualification": widget.qualification,
      "Salary": widget.Salary,
      "experience": widget.experience,
      "LastDateOfApply": widget.LastDateOfApply?.toIso8601String() ?? "",
      "Location": widget.Location,
      "Description": widget.Description,
      "noofvacancie": widget.noofvacancie,
      "jobstatus": 'Closed'
    };
    var boddy = jsonEncode(data);
    var urlParse = Uri.parse(url);

    try {
      http.Response response = await http.put(urlParse,
          body: boddy, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        // Navigation logic goes here
        Navigator.pop(context); // Assuming you have access to the context

        // Alternatively, you can use named routes for navigation
        // Navigator.pushNamed(context, '/previous_screen');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
