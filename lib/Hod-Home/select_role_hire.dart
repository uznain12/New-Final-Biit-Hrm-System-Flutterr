import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'package:hrm_final_project/Models/hod_remark_model.dart';
import 'package:hrm_final_project/uri.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SelectRole extends StatefulWidget {
  int? appuid;
  int? jobappid;
  int? Jid;

  SelectRole(
      {super.key,
      required this.appuid,
      required this.jobappid,
      required this.Jid});

  @override
  State<SelectRole> createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  List<RemarkModel> remarklist = [];
  File? documentPath;
  @override
  void initState() {
    super.initState();
    if (widget.appuid == null) {
      print("jobappid is null");
      // Handle the case when jobappid is null
    } else {
      print("jobappid is not null");
      print("jobappid: ${widget.appuid}");
      // Handle the case when jobappid is not null
    }
  }

  String? _selectrole;
  List<String> _roles = [
    'employee',
    'guard',
    'hr',
  ]; //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selection User Role "),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
              future: getEmployeeRemarks(widget.jobappid!),
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
                          itemCount: 1,
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
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: [
                                          const TextSpan(
                                            text: "Job Title:                 ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          TextSpan(
                                            text: remarklist[index]
                                                .jobApplicationName,
                                            style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: InputDecorator(
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.school),
                                          prefixIconConstraints: BoxConstraints(
                                            minWidth: 54,
                                            minHeight: 54,
                                          ),
                                          border: OutlineInputBorder(),
                                        ),
                                        child: DropdownButtonFormField<String>(
                                          hint: const Text(
                                            "Please Select Job Post",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          isExpanded: true,
                                          value: _selectrole,
                                          items: _roles.map((String option) {
                                            return DropdownMenuItem(
                                              value: option,
                                              child: Text(option),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              _selectrole = newValue;
                                            });
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please select a Post';
                                            }
                                            return null;
                                          },
                                        ),
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
                                                HireUser();
                                              },
                                              child: Text("YES")),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Back"))
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

  Future<List<RemarkModel>> getEmployeeRemarks(int jobappid) async {
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Remark/MembersRemarksGet?jobid=$jobappid&Jid=${widget.Jid}&Uid=${widget.appuid}'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      remarklist.clear();
      for (Map<String, dynamic> index in data) {
        remarklist.add(RemarkModel.fromJson(index));
      }
    } else {
      print(
          'Error occurred: ${response.statusCode} - ${response.body}'); // print the error
    }
    return remarklist;
  }

  void HireUser() async {
    var url =
        "http://$ip/HrmPractise02/api/User/UpdateUsserAndAttributeReaminssame";
    var data = {"Uid": widget.appuid, "role": _selectrole.toString()};

    var boddy = jsonEncode(data);
    var urlParse = Uri.parse(url);

    try {
      http.Response response = await http.put(urlParse,
          body: boddy, headers: {"Content-Type": "application/json"});
      var dataa = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Call Updatejobapplication and show success message only if it succeeds
        await Updatejobapplication();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("User Hired"),
              content: Text("The user has been hired successfully."),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Show error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("An error occurred while hiring the user."),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> Updatejobapplication() async {
    var url =
        "http://$ip/HrmPractise02/api/JobApplication/UpdateJobapplication";
    var data = {
      "JobApplicationID": widget.jobappid,
      "Jid": widget.Jid,
      "Uid": widget.appuid,
      "status": "Hired",

      // Change this to the appropriate value
    };
    var boddy = jsonEncode(data);
    var urlParse = Uri.parse(url);
    try {
      http.Response response = await http.put(urlParse,
          body: boddy, headers: {"Content-Type": "application/json"});
      var dataa = jsonDecode(response.body);
      print(dataa);
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
