import 'package:flutter/material.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_approved_leaves.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_leave_applications.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_rejected_leaves.dart';
import 'package:hrm_final_project/Hr-Home/Leave/leave_detail_action.dart';
import 'package:hrm_final_project/Models/leave_and_user_model.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class AllPendingLeave extends StatefulWidget {
  const AllPendingLeave({
    super.key,
  });

  @override
  State<AllPendingLeave> createState() => _AllPendingLeaveState();
}

class _AllPendingLeaveState extends State<AllPendingLeave> {
  List<Leavewithusermodel> laveapplicationlist = [];
  String _formatDate(DateTime date) {
    //ya date ko sai sa show karwanay ka liya bnaya ha like is format ma show hogi date
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  void initState() {
    super.initState();
  }

  _Filter? _selectedFilter; //This line only use for dropdownfilter

  final List<_Filter> _filters = [
    _Filter(name: 'approved', isSelected: false),
    _Filter(name: 'rejected', isSelected: false),
    _Filter(name: 'pending', isSelected: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pending Applications"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: fetchleaveapplication(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Leavewithusermodel> filteredLeaveApplications = [];
                if (_filters.any((filter) => filter.isSelected)) {
                  for (final leaveApplication in laveapplicationlist) {
                    for (final filter in _filters) {
                      if (filter.isSelected &&
                          leaveApplication.status.toLowerCase().trim() ==
                              filter.name.toLowerCase().trim()) {
                        filteredLeaveApplications.add(leaveApplication);
                        break;
                      }
                    }
                  }
                } else {
                  filteredLeaveApplications = List.from(laveapplicationlist);
                }
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.40),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 2.0),
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: DropdownButton<_Filter>(
                          hint: Text(
                            'Select Leave',
                            style: TextStyle(color: Colors.red),
                          ),
                          value: _selectedFilter,
                          onChanged: (_Filter? newValue) {
                            setState(() {
                              _selectedFilter = newValue;
                              if (_selectedFilter != null) {
                                _selectedFilter!.isSelected =
                                    !_selectedFilter!.isSelected;
                              }
                            });
                          },
                          items: _filters
                              .map<DropdownMenuItem<_Filter>>((_Filter filter) {
                            return DropdownMenuItem<_Filter>(
                              value: filter,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(filter.name),
                                  if (filter.isSelected)
                                    Icon(
                                      Icons.check,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment
                    //       .spaceAround, // distribute buttons evenly
                    //   children: <Widget>[
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) =>
                    //                     AllLeaveApplications()));
                    //         // button press code here
                    //       },
                    //       child: const Text('All'),
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => AllAprovedLeave()));
                    //         // button press code here
                    //       },
                    //       child: const Text('Approved'),
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => AllRejectedLeaves()));
                    //         // button press code here
                    //       },
                    //       child: const Text('Rejected'),
                    //     ),
                    //   ],
                    // ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: filteredLeaveApplications.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
                                  left:
                                      MediaQuery.of(context).size.height * 0.01,
                                  right: MediaQuery.of(context).size.height *
                                      0.01),
                              child: Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade300,
                                  border:
                                      Border.all(width: 5, color: Colors.black),
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
                                      top: MediaQuery.of(context).size.height *
                                          0.03),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
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
                                                  text: "Applicant Name :    ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${filteredLeaveApplications[index].fname} ${filteredLeaveApplications[index].lname} ",
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
                                                  text:
                                                      "Leave Type:              ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      // ignore: unnecessary_string_interpolations
                                                      "${filteredLeaveApplications[index].leavetype}",
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
                                                  text: "Apply Date :    ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${_formatDate(DateTime.parse(filteredLeaveApplications[index].applydate.toString()))}",
                                                ),
                                              ]),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
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
                                                  text: "Status :    ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${filteredLeaveApplications[index].status} ",
                                                  style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Center(
                                        child: SizedBox(
                                          width: 200,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LeaveDetailPlusAction(
                                                              uid:
                                                                  filteredLeaveApplications[
                                                                          index]
                                                                      .uid,
                                                              reson:
                                                                  filteredLeaveApplications[
                                                                          index]
                                                                      .reason,
                                                              leavetype:
                                                                  filteredLeaveApplications[
                                                                          index]
                                                                      .leavetype,
                                                              sdate:
                                                                  filteredLeaveApplications[
                                                                          index]
                                                                      .startdate,
                                                              edate:
                                                                  filteredLeaveApplications[
                                                                          index]
                                                                      .enddate,
                                                              apdate:
                                                                  filteredLeaveApplications[
                                                                          index]
                                                                      .applydate,
                                                              leavid:
                                                                  filteredLeaveApplications[
                                                                          index]
                                                                      .leaveappid,
                                                            )));
                                              },
                                              child: const Text("Detail")),
                                        ),
                                      )
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
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<List<Leavewithusermodel>> fetchleaveapplication() async {
    //response keyword khud sa bnaya ha
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Leave/NewAllLeaveapplicationGet')); // is ma aik variable bnaya ha response ka name sa or phir get method ka through api ko hit kar rahay hn is ka data aik data variable ma store karway ga
    // ignore: non_constant_identifier_names
    var Data = jsonDecode(response.body
        .toString()); // decode kar ka data variable ma store kar rahay hn
    if (response.statusCode == 200) {
      laveapplicationlist.clear();
      for (Map<String, dynamic> index in Data) {
        laveapplicationlist.add(Leavewithusermodel.fromJson(index));
      }
      return laveapplicationlist;
    } else {
      return laveapplicationlist;
    }
  }
}

class _Filter {
  String name;
  bool isSelected;

  _Filter({required this.name, required this.isSelected});
}
