import 'dart:collection';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:hrm_final_project/Hr-Home/Job/assign_job_tocommitte.dart';
import 'package:hrm_final_project/Hr-Home/Job/jobapplications_detail.dart';
import 'package:hrm_final_project/Models/hr_side_job_user_jobapplication_model.dart';
import 'package:hrm_final_project/uri.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class JobApplications extends StatefulWidget {
  int? uid;
  JobApplications({super.key, required this.uid});

  @override
  State<JobApplications> createState() => _JobApplicationsState();
}

class _JobApplicationsState extends State<JobApplications> {
  List<JobuserjobapplicationmodelDart> jobapplicationlist = [];

  List<int> selectedItems = []; // Temporary array to store selected items

  _Filter? _selectedFilter; //This line only use for dropdownfilter

  final List<_Filter> _filters = [
    _Filter(name: 'Guard', isSelected: false),
    _Filter(name: 'Lab Attendant', isSelected: false),
    _Filter(name: 'Junior Lecturer', isSelected: false),
    _Filter(name: 'Lectruer', isSelected: false),
    _Filter(name: 'Assistant Professor', isSelected: false),
    _Filter(name: 'Professor', isSelected: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Job Applications"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: fetchcuser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<JobuserjobapplicationmodelDart> filteredJobApplications =
                    [];
                if (_filters.any((filter) => filter.isSelected)) {
                  for (final jobApplication in jobapplicationlist) {
                    for (final filter in _filters) {
                      if (filter.isSelected &&
                          jobApplication.title.toLowerCase().trim() ==
                              filter.name.toLowerCase().trim()) {
                        filteredJobApplications.add(jobApplication);
                        break;
                      }
                    }
                  }
                } else {
                  filteredJobApplications = List.from(jobapplicationlist);
                }
                return Column(children: [
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
                          'Select Job',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing:
                              5.0, // Decreased from MediaQuery.of(context).size.height * 0.09
                          crossAxisSpacing:
                              10.0, // Decreased from MediaQuery.of(context).size.width * 0.09
                          childAspectRatio: 3.2 / 3.2,
                        ),
                        itemCount: filteredJobApplications.length,
                        itemBuilder: ((context, index) {
                          bool isSelected = selectedItems.contains(index);
                          return Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03,
                              left: MediaQuery.of(context).size.width * 0.01,
                              right: MediaQuery.of(context).size.width * 0.01,
                            ),
                            child: GestureDetector(
                              // onLongPress: () {},
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    //ya isSelected ko itembuilder ka ander create kiya ha or isayselecteditems ka index da diya ha
                                    selectedItems.remove(
                                        index); // Item is already selected, remove it from the list
                                  } else {
                                    selectedItems.add(
                                        index); // Item is not selected, add it to the list
                                  }
                                });

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             JobApplicationDetail(
                                //               uid: widget.uid,
                                //               applicationid:
                                //                   filteredJobApplications[index]
                                //                       .jobApplicationId,
                                //             )));
                              },
                              child: Stack(children: [
                                Container(
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
                                                        "Job Title :                    ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "${filteredJobApplications[index].title}",
                                                    style: const TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
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
                                                        "Applicant Name :    ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "${filteredJobApplications[index].fname} "
                                                        " ${filteredJobApplications[index].lname}",
                                                    style: const TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        // Padding(
                                        //   padding:
                                        //       const EdgeInsets.only(left: 30),
                                        //   child: ElevatedButton(
                                        //       onPressed: () {
                                        //         Navigator.push(
                                        //             context,
                                        //             MaterialPageRoute(
                                        //                 builder: (context) =>
                                        //                     AssignJobToCommittee(
                                        //                       uid: widget.uid,
                                        //                       jobappid:
                                        //                           filteredJobApplications[
                                        //                                   index]
                                        //                               .jobApplicationId,
                                        //                     )));
                                        //       },
                                        //       child: const Text("Assign Job")),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                                if (isSelected) // Add this line
                                  const Positioned(
                                    top:
                                        5, // Adjust the position of the tick mark as per your design
                                    right:
                                        5, // Adjust the position of the tick mark as per your design
                                    child: Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                      size: 40,
                                    ),
                                  ),
                              ]),
                            ),
                          );
                        })),
                  ),
                  Visibility(
                    visible: selectedItems.isNotEmpty,
                    child: ElevatedButton(
                      onPressed: () {
                        // Use the selectedItems array to perform some action on the selected items
                        List<JobuserjobapplicationmodelDart>
                            selectedJobApplications = [];
                        for (int index in selectedItems) {
                          selectedJobApplications
                              .add(filteredJobApplications[index]);
                          print(
                              'Selected item index: $index, ID: ${filteredJobApplications[index].jobApplicationId}');
                          // Perform action with the selected item
                        }

                        // Navigate to the next page and pass the selected job applications
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssignJobToCommittee(
                              uid: widget.uid,
                              jobappid: selectedJobApplications
                                  .map((job) => job.jobApplicationId)
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      child: const Text("Perform Action"),
                    ),
                  )
                ]);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<List<JobuserjobapplicationmodelDart>> fetchcuser() async {
    //response keyword khud sa bnaya ha
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/JobApplication/NewAllJobApplicationsGet')); // is ma aik variable bnaya ha response ka name sa or phir get method ka through api ko hit kar rahay hn is ka data aik data variable ma store karway ga
    var Data = jsonDecode(response.body
        .toString()); // decode kar ka data variable ma store kar rahay hn
    if (response.statusCode == 200) {
      jobapplicationlist.clear();
      if (Data is Map<String, dynamic>) {
        jobapplicationlist.add(JobuserjobapplicationmodelDart.fromJson(Data));
      } else if (Data is List) {
        for (Map<String, dynamic> index in Data) {
          jobapplicationlist
              .add(JobuserjobapplicationmodelDart.fromJson(index));
        }
      }
      return jobapplicationlist;
    } else {
      return jobapplicationlist;
    }
  }
}

class _Filter {
  String
      name; // is name ko snapshot has data ka nechay jo condition ha us ma title ka equal kiya huva ha to ya title ki base pa result show karway gi
  bool isSelected;

  _Filter({required this.name, required this.isSelected});
}
