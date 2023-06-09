import 'package:flutter/material.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_approved_leaves.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_pending_leaves.dart';
import 'package:hrm_final_project/Hr-Home/Leave/all_rejected_leaves.dart';
import 'package:hrm_final_project/Hr-Home/Leave/total_leave_detail.dart';
import 'package:hrm_final_project/Models/leave_and_user_model.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllLeaveApplications extends StatefulWidget {
  const AllLeaveApplications({
    super.key,
  });

  @override
  State<AllLeaveApplications> createState() => _AllLeaveApplicationsState();
}

class _AllLeaveApplicationsState extends State<AllLeaveApplications> {
  List<Leavewithusermodel> laveapplicationlist = [];

  // ignore: unused_field
  late Widget _widget;
  @override
  void initState() {
    super.initState();
    _widget = AllLeaveApplications();
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
          title: Text("Leave Applications"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: fetchleaveapplication(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Leavewithusermodel> filteredJLeaveApplications = [];
                if (_filters.any((filter) => filter.isSelected)) {
                  for (final leaveApplication in laveapplicationlist) {
                    for (final filter in _filters) {
                      if (filter.isSelected &&
                          leaveApplication.status
                                  .toString()
                                  .trim()
                                  .toLowerCase() ==
                              filter.name.toLowerCase().trim()) {
                        filteredJLeaveApplications.add(leaveApplication);
                        break;
                      }
                    }
                  }
                } else {
                  filteredJLeaveApplications = List.from(laveapplicationlist);
                }
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.36),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 2.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: DropdownButton<_Filter>(
                          hint: const Text(
                            'Leave Type',
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
                    //                 builder: (context) => AllPendingLeave()));
                    //         // button press code here
                    //       },
                    //       child: Text('pending'),
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => AllAprovedLeave()));
                    //         // button press code here
                    //       },
                    //       child: Text('Approved'),
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
                    // ),,

                    Expanded(
                      child: ListView.builder(
                          itemCount: filteredJLeaveApplications.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.03),
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    border: Border.all(
                                        width: 4, color: Colors.black)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.03),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // RichText(
                                      //   text: TextSpan(
                                      //       style: DefaultTextStyle.of(context).style,
                                      //       children: [
                                      //         const TextSpan(
                                      //           text: "First Name: ",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //           ),
                                      //         ),
                                      //         TextSpan(
                                      //           text: "${userlist[index].fname}",
                                      //           style: const TextStyle(
                                      //             fontStyle: FontStyle.italic,
                                      //           ),
                                      //         ),
                                      //       ]),
                                      // ),
                                      // Text("First Name: ${userlist[index].fname}"),

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
                                                  text: "Applicant Name :    ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${filteredJLeaveApplications[index].fname} ${filteredJLeaveApplications[index].lname} ",
                                                  style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                  ),
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
                                                  text:
                                                      "Leave Type:                 ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${filteredJLeaveApplications[index].leavetype}",
                                                  style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                  ),
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
                                                  text:
                                                      "Status:                 ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${filteredJLeaveApplications[index].status}",
                                                  style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
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
                                                            TotalLeaveDetailOfApplicant(
                                                              uid:
                                                                  filteredJLeaveApplications[
                                                                          index]
                                                                      .uid,
                                                              reson:
                                                                  filteredJLeaveApplications[
                                                                          index]
                                                                      .reason,
                                                              leavetype:
                                                                  filteredJLeaveApplications[
                                                                          index]
                                                                      .leavetype,
                                                              sdate:
                                                                  filteredJLeaveApplications[
                                                                          index]
                                                                      .startdate,
                                                              edate:
                                                                  filteredJLeaveApplications[
                                                                          index]
                                                                      .enddate,
                                                              apdate:
                                                                  filteredJLeaveApplications[
                                                                          index]
                                                                      .applydate,
                                                              leavid:
                                                                  filteredJLeaveApplications[
                                                                          index]
                                                                      .leaveappid,
                                                            )));
                                              },
                                              child: Text("Detail")),
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
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<List<Leavewithusermodel>> fetchleaveapplication() async {
    //response keyword khud sa bnaya ha
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Leave/NewAllLeaveapplicationGet')); // is ma aik variable bnaya ha response ka name sa or phir get method ka through api ko hit kar rahay hn is ka data aik data variable ma store karway ga
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
  String
      name; // is name ko snapshot has data ka nechay jo condition ha us ma title ka equal kiya huva ha to ya title ki base pa result show karway gi
  bool isSelected;

  _Filter({required this.name, required this.isSelected});
}
