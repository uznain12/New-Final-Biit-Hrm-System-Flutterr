import 'dart:convert';
import 'package:hrm_final_project/Guard-Home/attendance_report_detail.dart';
import 'package:hrm_final_project/Models/attendance_model.dart';
import 'package:hrm_final_project/Models/user_model.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AttendanceReport extends StatefulWidget {
  final Usermodel selectedEmployee;
  AttendanceReport({Key? key, required this.selectedEmployee})
      : super(key: key);
  // const ApplicantApplyJob({super.key});

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  List<Attendancemodel> attendancewithidlist = [];
  late Future<Usermodel> selectedEmployee;

  void _filterAttendance() {
    if (mounted) {
      setState(() {
        attendancewithidlist = attendancewithidlist.where((record) {
          DateTime recordDate = DateTime.parse(record.date.toIso8601String());
          return recordDate.isAfter(_startDate) &&
              recordDate.isBefore(_endDate);
        }).toList();
      });
    }
  }

  String _formatDate(DateTime date) {
    //ya date ko sai sa show karwanay ka liya bnaya ha like is format ma show hogi date
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String _searchQuery = ''; // User for search

  // Bottom navbar
  late Widget _widget;
  @override
  void initState() {
    super.initState();
  }

  DateTime _startDate = DateTime(2000); // date filter ka liya use hoi ha
  DateTime _endDate = DateTime(2024);
  @override
  Widget build(BuildContext context) {
    Usermodel selectedEmployee = widget.selectedEmployee;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Attendance Report',
          style: TextStyle(
              fontFamily: 'RobotoSlab-Black',
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w900),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
              future: attendancebyid(widget.selectedEmployee.uid!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _startDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2400),
                              );
                              if (pickedDate != null &&
                                  pickedDate != _startDate) {
                                setState(() {
                                  _startDate = pickedDate;
                                  _filterAttendance();
                                });
                              }
                            },
                            child: Text("From: ${_formatDate(_startDate)}"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _endDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2400),
                              );
                              if (pickedDate != null &&
                                  pickedDate != _endDate) {
                                setState(() {
                                  _endDate = pickedDate;
                                  _filterAttendance();
                                });
                              }
                            },
                            child: Text("To: ${_formatDate(_endDate)}"),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: attendancewithidlist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.width * 0.02,
                                right: MediaQuery.of(context).size.width * 0.02,
                              ),
                              child: InkWell(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AttendanceReportDeatil(
                                                  uid: attendancewithidlist[
                                                          index]
                                                      .uid,
                                                  Date: attendancewithidlist[
                                                          index]
                                                      .date)));
                                }),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: RichText(
                                          text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: [
                                                const TextSpan(
                                                  text: "Date:        ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${_formatDate(DateTime.parse(attendancewithidlist[index].date.toString()))}",
                                                  style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: RichText(
                                          text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: [
                                                const TextSpan(
                                                  text: "Status:        ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${attendancewithidlist[index].status}",
                                                  style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ]),
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
        ),
      ),
    );
  }

  Future<List<Attendancemodel>> attendancebyid(int id) async {
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Attendance/NewAttendanceGet?uid=$id'));
    var Data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      attendancewithidlist.clear();

      Set<String> uniqueDates = {}; // Create a set to store unique dates
      List<Map<String, dynamic>> uniqueData =
          []; // Create a list to store unique records

      for (Map<String, dynamic> index in Data) {
        // Check if the date is already in the set
        if (!uniqueDates.contains(index['date'])) {
          uniqueDates.add(index['date']); // Add the date to the set
          uniqueData.add(index); // Add the record to the unique records list
        }
      }

      for (Map<String, dynamic> index in uniqueData) {
        attendancewithidlist.add(Attendancemodel.fromJson(index));
      }
      _filterAttendance();

      return attendancewithidlist;
    } else {
      return attendancewithidlist;
    }
  }
}
