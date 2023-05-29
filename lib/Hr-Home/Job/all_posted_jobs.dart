import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrm_final_project/Models/job_model.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AllPostedJobs extends StatefulWidget {
  int? uid;
  AllPostedJobs({required this.uid});
  // const ApplicantApplyJob({super.key});

  @override
  State<AllPostedJobs> createState() => _AllPostedJobsState();
}

class _AllPostedJobsState extends State<AllPostedJobs> {
  List<Jobmodel> joblist = [];
  @override
  void initState() {
    super.initState();
  }

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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'All Jobs',
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
              future: getjob(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Jobmodel> filteredJobApplications = [];
                  if (_filters.any((filter) => filter.isSelected)) {
                    for (final jobApplication in joblist) {
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
                    filteredJobApplications = List.from(joblist);
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
                            items: _filters.map<DropdownMenuItem<_Filter>>(
                                (_Filter filter) {
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
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing:
                                10.0, // Decreased from MediaQuery.of(context).size.height * 0.09
                            crossAxisSpacing:
                                1.0, // Decreased from MediaQuery.of(context).size.width * 0.09
                            childAspectRatio: 3 / 1.1,
                          ),
                          itemCount: filteredJobApplications.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0,
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
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.01,
                                      left: MediaQuery.of(context).size.width *
                                          0.01),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Title: ${filteredJobApplications[index].title}",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Salary:${filteredJobApplications[index].salary.toString()}",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Location:   ${filteredJobApplications[index].location}",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title:
                                                      const Text('Delete job?'),
                                                  content: const Text(
                                                      'Are you sure you want to delete this job?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        _deleteJob(
                                                            filteredJobApplications[
                                                                    index]
                                                                .jid);
                                                      },
                                                      child: Text('Delete'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.delete),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.edit))
                                        ],
                                      )
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

  Future<List<Jobmodel>> getjob(
    BuildContext context,
  ) async {
    // Get the current user's UID.
    final response =
        await http.get(Uri.parse('http://$ip/HrmPractise02/api/Job/NewJobGet'));
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

  Future<void> _deleteJob(int jobId) async {
    final response = await http.delete(
      Uri.parse('http://$ip/HrmPractise02/api/Job/DeleteJob?Jid=$jobId'),
    );

    if (response.statusCode == 200) {
      // Refresh job list
      setState(() {
        joblist.removeWhere((job) => job.jid == jobId);
      });
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete job')),
      );
    }
  }
}

class _Filter {
  String name;
  bool isSelected;

  _Filter({required this.name, required this.isSelected});
}
