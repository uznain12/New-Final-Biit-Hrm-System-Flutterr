// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hrm_final_project/Models/leave-user-3.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class WithFilterEmployeeApplyForLeave extends StatefulWidget {
  int? uid;
  WithFilterEmployeeApplyForLeave({super.key, required this.uid});
  // const AddEducation({super.key});

  @override
  State<WithFilterEmployeeApplyForLeave> createState() =>
      _WithFilterEmployeeApplyForLeaveState();
}

List<Leavewithusermodel3> laveapplicationlist = [];

String? _selectedOption;
List<String> _options = [
  'Sick',
  'Earned',
  'Casual',
  'Annual',
]; // op

TextEditingController _instituteController = TextEditingController();

TextEditingController _startDateController = TextEditingController();
TextEditingController _endDateController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<
    ScaffoldState>(); // only use for show dialogbox on status code 200

class _WithFilterEmployeeApplyForLeaveState
    extends State<WithFilterEmployeeApplyForLeave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey, // only use for show dialogbox on status code 200
        appBar: AppBar(
          title: const Text("Apply For Leave"),
          centerTitle: true,
        ),
        body: Stack(children: [
          FutureBuilder(
              future: fetchleaveapplication(widget.uid!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: laveapplicationlist.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.03,
                                  left:
                                      MediaQuery.of(context).size.width * 0.02,
                                  right:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300,
                                    border: Border.all(
                                        width: 5, color: Colors.black),
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
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text:
                                                            "Total Sick Allowed :   ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${laveapplicationlist[index].maxSickAllow}",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("|"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text: "Taken : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${laveapplicationlist[index].totalSick}",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("|"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text: "Remaining : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${laveapplicationlist[index].remainingSick}",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text:
                                                            "Total Annual Allowed : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${laveapplicationlist[index].maxAnnualAllow}",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("|"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text: "Taken : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${laveapplicationlist[index].totalAnnual}",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("|"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text: "Remaining : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${laveapplicationlist[index].remainingAnnual}",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text:
                                                            "Total Casual Allowed : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${laveapplicationlist[index].maxCasualAllow}",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("|"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text: "Taken : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${laveapplicationlist[index].totalCasual}",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("|"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text: "Remaining : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${laveapplicationlist[index].remainingCasual}",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text:
                                                            "Total Earned Allowed : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${laveapplicationlist[index].maxEarnedAllow}",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("|"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text: "Taken : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${laveapplicationlist[index].totalEarned}",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("|"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      const TextSpan(
                                                        text: "Remaining : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${laveapplicationlist[index].remainingEarned}",
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ),
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
                  return Center(child: CircularProgressIndicator());
                }
              }),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.height * 0.01),
              child: Container(
                height: 800,
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    InputDecorator(
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
                          "Leave Type",
                          style: TextStyle(fontSize: 20),
                        ),
                        isExpanded: true,
                        value: _selectedOption,
                        items: _options.map((String option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedOption = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a degree';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _instituteController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.school_sharp),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 54,
                          minHeight: 54,
                        ),
                        labelText: 'Reason',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your reason';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _startDateController,
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2300));
                              if (picked != null) {
                                setState(() {
                                  _startDateController.text =
                                      picked.toString().split(' ')[0];
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'Start Date',
                              prefixIcon: Icon(Icons.calendar_today),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 54,
                                minHeight: 54,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Select Start Date';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _endDateController,
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2300));
                              if (picked != null) {
                                setState(() {
                                  _endDateController.text =
                                      picked.toString().split(' ')[0];
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'End Date',
                              prefixIcon: Icon(Icons.calendar_today),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 54,
                                minHeight: 54,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Select End Date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              AddLeaverequest(
                                Uid: widget.uid,
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ]));
  }

  void AddLeaverequest({
    int? Uid,
  }) async {
    var url = "http://$ip/HrmPractise02/api/Leave/LeavePost";
    var data = {
      "Uid": widget.uid,
      "reason": _instituteController.text,
      "startdate": _startDateController.text,
      "enddate": _endDateController.text,
      "leavetype": _selectedOption,
      "status": "pending", // Change this to the appropriate value
      "applydate": DateTime.now().toIso8601String(),
    };
    var boddy = jsonEncode(data);
    var urlParse = Uri.parse(url);
    try {
      http.Response response = await http.post(urlParse,
          body: boddy, headers: {"Content-Type": "application/json"});
      var dataa = jsonDecode(response.body);
      print(dataa);
      if (response.statusCode == 200) {
        // Reset form and clear controllers
        _formKey.currentState?.reset();
        _instituteController.clear();
        _startDateController.clear();
        _endDateController.clear();
        _selectedOption = null; // Reset the dropdown

        showDialog(
          context: _scaffoldKey.currentContext!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Your Leave Application Submitted'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
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

  Future<List<Leavewithusermodel3>> fetchleaveapplication(int id) async {
    //response keyword khud sa bnaya ha
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Extra/RemainingTotalNewLeaveWithIDGet?uid=$id')); // is ma aik variable bnaya ha response ka name sa or phir get method ka through api ko hit kar rahay hn is ka data aik data variable ma store karway ga
    var Data = jsonDecode(response.body
        .toString()); // decode kar ka data variable ma store kar rahay hn
    if (response.statusCode == 200) {
      laveapplicationlist.clear();

      if (Data is Map<String, dynamic>) {
        laveapplicationlist.add(Leavewithusermodel3.fromJson(Data));
      } else if (Data is List) {
        for (Map<String, dynamic> index in Data) {
          laveapplicationlist.add(Leavewithusermodel3.fromJson(index));
        }
      }
      return laveapplicationlist;
    } else {
      return laveapplicationlist;
    }
  }
}
