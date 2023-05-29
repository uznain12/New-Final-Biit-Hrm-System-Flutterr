import 'package:flutter/material.dart';
import 'package:hrm_final_project/Models/leave_and_user_model.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaveDetailPlusAction extends StatefulWidget {
  final int leavid;
  int? uid;
  String? reson;
  String? leavetype;
  String? sdate;
  String? edate;
  DateTime? apdate;

  // ignore: prefer_const_constructors_in_immutables
  LeaveDetailPlusAction({
    super.key,
    required this.leavid,
    required this.uid,
    required this.sdate,
    required this.edate,
    required this.apdate,
    required this.reson,
    required this.leavetype,
  });

  @override
  State<LeaveDetailPlusAction> createState() => _LeaveDetailPlusActionState();
}

class _LeaveDetailPlusActionState extends State<LeaveDetailPlusAction> {
  late Future<List<Leavewithusermodel>> leaveApplicationFuture;

  @override
  void initState() {
    super.initState();
    leaveApplicationFuture = fetchLeaveApplication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application Detail"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Leavewithusermodel>>(
        future: leaveApplicationFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final leaveApplicationList = snapshot.data!;
            return ListView.builder(
              itemCount: leaveApplicationList.length,
              itemBuilder: (context, index) {
                final application = leaveApplicationList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      border: Border.all(width: 4, color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Applicant Name:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${application.fname} ${application.lname}",
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Leave Type:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            application.leavetype,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "From Date:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            application.startdate,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "To Date:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            application.enddate,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Reason:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            application.reason,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  approveleave(context: context);
                                },
                                child: const Text("Approve"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  rejectleave(
                                    context: context,
                                  );
                                },
                                child: const Text("Reject"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<Leavewithusermodel>> fetchLeaveApplication() async {
    try {
      final response = await http.get(Uri.parse(
          'http://$ip/HrmPractise02/api/Leave/LeaveWithIDGet?leaveappid=${widget.leavid}'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return List<Leavewithusermodel>.from(
            jsonData.map((x) => Leavewithusermodel.fromJson(x)));
      } else {
        throw Exception('Failed to fetch leave application');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  void rejectleave({
    BuildContext? context,
  }) async {
    var url = "http://$ip/HrmPractise02/api/Leave/UpdateLeave";
    var data = {
      "leaveappid": widget.leavid,
      "Uid": widget.uid,
      "startdate": widget.sdate,
      "reason": widget.reson,
      "enddate": widget.edate,
      "leavetype": widget.leavetype,
      "applydate": widget.apdate?.toIso8601String() ?? "",
      "status": 'rejected'
    };
    var boddy = jsonEncode(data);
    var urlParse = Uri.parse(url);
    try {
      http.Response response = await http.put(urlParse,
          body: boddy, headers: {"Content-Type": "application/json"});
      var dataa = jsonDecode(response.body);
      print(dataa);

      if (response.statusCode == 200) {
        // Navigate to the previous screen if the request was successful
        if (context != null) Navigator.pop(context);
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  void approveleave({
    BuildContext? context,
  }) async {
    var url = "http://$ip/HrmPractise02/api/Leave/UpdateLeave";
    var data = {
      "leaveappid": widget.leavid,
      "Uid": widget.uid,
      "startdate": widget.sdate,
      "reason": widget.reson,
      "enddate": widget.edate,
      "leavetype": widget.leavetype,
      "applydate": widget.apdate?.toIso8601String() ?? "",
      "status": 'approved'
    };

    var boddy = jsonEncode(data);
    var urlParse = Uri.parse(url);
    try {
      http.Response response = await http.put(urlParse,
          body: boddy, headers: {"Content-Type": "application/json"});
      var dataa = jsonDecode(response.body);
      print(dataa);

      if (response.statusCode == 200) {
        // Navigate to the previous screen if the request was successful
        if (context != null) Navigator.pop(context);
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
