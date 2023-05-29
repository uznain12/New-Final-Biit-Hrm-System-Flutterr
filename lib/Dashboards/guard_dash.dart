// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:hrm_final_project/Applicant-Home/Personal/personal_info.dart';
import 'package:hrm_final_project/Guard-Home/all_employees_attendance.dart';
import 'package:hrm_final_project/Guard-Home/checkin.dart';
import 'package:hrm_final_project/Guard-Home/checkout.dart';
import 'package:hrm_final_project/Login-Signup/login.dart';
import 'package:hrm_final_project/Models/attendance_model.dart';
import 'package:hrm_final_project/Models/user_model.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class GuardDashboard extends StatefulWidget {
  int? uid;
  GuardDashboard({required this.uid});

  @override
  State<GuardDashboard> createState() => _GuardDashboardState();
}

List<Usermodel> userlist =
    []; // ya model jo guard login ha uski profile show karway ga
List<Usermodel> userlistbyrole =
    []; // ya model employees ko show karway a card ma
List<Attendancemodel> attendancewithidlist =
    []; // is model sa attendance ki id la ka bhejay ga checkout pa update karnay ka liya

class _GuardDashboardState extends State<GuardDashboard> {
  Map<int, bool> userCheckStatus =
      {}; // New map to store the check-in/check-out status

  @override
  void initState() {
    super.initState();
    fetchcuser(widget.uid!).then((_) {
      setState(() {});
    });
  }

  String _searchQuery = ''; // User for search

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Welcome: ${userlist.isNotEmpty ? userlist[0].fname : ''} ${userlist.isNotEmpty ? userlist[0].lname : ''}",
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text(
                  "${userlist.isNotEmpty ? userlist[0].fname : ''} ${userlist.isNotEmpty ? userlist[0].lname : ''}",
                  style: TextStyle(fontSize: 20),
                ),
                accountEmail:
                    Text("${userlist.isNotEmpty ? userlist[0].email : ''}"),
                currentAccountPicture: CircleAvatar(
                  child: userlist.isNotEmpty && userlist[0].image.isNotEmpty
                      ? ClipOval(
                          child: Image(
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                              image:
                                  NetworkImage(imagepath + userlist[0].image)),
                        )
                      : const SizedBox.shrink(),
                )),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppPersonalInfo(uid: widget.uid),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Attendance'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceMainPage(
                      uid: widget.uid,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ApplicantApplyApplications(),
                //   ),
                // );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Log Out',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.clear();
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background image container
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/background.jpg'),
                    fit: BoxFit.fill)),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter Emplyee name',
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // FutureBuilder to fetch data asynchronously
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 10, right: 10),
            child: Container(
              // decoration: BoxDecoration(color: Colors.black),
              child: FutureBuilder(
                  future: fetchcuserbyrole(),
                  builder: (context, snapshot) {
                    // If the snapshot has data, build the grid
                    if (snapshot.hasData) {
                      List<Usermodel> filteredUsers = [];
                      if (_searchQuery.isNotEmpty) {
                        for (final user in userlistbyrole) {
                          if (((user.fname?.toLowerCase() ?? '') +
                                  ' ' +
                                  (user.lname?.toLowerCase() ?? ''))
                              .contains(_searchQuery.toLowerCase())) {
                            filteredUsers.add(user);
                          }
                        }
                      } else {
                        filteredUsers = List.from(userlistbyrole);
                      }

                      return GridView.builder(
                          itemCount: filteredUsers.length,
                          // Define the grid with 2 columns and spacing
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                2, // Ya isko 2 kiya matlab 1 line ma 2 records show hongay
                            crossAxisSpacing:
                                10, // ya 1 line ma 2 records ka darmayan space di ha
                            mainAxisSpacing:
                                10, // or ya line 1 or line 2 ka records ma space di ha
                            childAspectRatio: 3 / 2.5,
                          ),
                          itemBuilder: (context, index) {
                            // Initialize the check status for each user if not already initialized
                            if (userCheckStatus[userlistbyrole[index].uid] ==
                                null) {
                              userCheckStatus[userlistbyrole[index].uid] =
                                  false;
                            }
                            // Create a card for each employee
                            return InkWell(
                              onTap: () async {
                                setState(() {
                                  userCheckStatus[filteredUsers[index].uid] =
                                      !userCheckStatus[
                                          filteredUsers[index].uid]!;
                                });

                                Attendancemodel?
                                    attendanceData = //Ya Bhot Important line ha iska matlab ha ka jo hum na data attendance model ka get kiya wo userlist by employee ko provide kar diya ha
                                    await fetchAttendanceByUid(
                                        filteredUsers[index].uid);

                                if (userCheckStatus[
                                    filteredUsers[index].uid]!) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GuardCheckIn(
                                              selectedEmployee:
                                                  filteredUsers[index],
                                              isCheckIn: true)));
                                } else {
                                  if (attendanceData != null) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GuardCheckOut(
                                                checkin: attendanceData.checkin,
                                                Attendanceid:
                                                    attendanceData.attendanceid,
                                                selectedEmployee:
                                                    filteredUsers[index],
                                                isCheckIn: false)));
                                  }
                                }
                              },
                              child: Card(
                                color:
                                    userCheckStatus[filteredUsers[index].uid]!
                                        ? Colors.green
                                        : Colors.red,
                                // color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                elevation:
                                    10, // ya shadow ka liya use hota ka hmara card zara backgroud sa utha utha huva nazr ay
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 90,
                                      // decoration:
                                      //     // BoxDecoration(color: Colors.black),
                                      child: filteredUsers[index]
                                              .image
                                              .isNotEmpty
                                          ? ClipOval(
                                              child: Image(
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                  width: 100,
                                                  image: NetworkImage(
                                                      imagepath +
                                                          filteredUsers[index]
                                                              .image)),
                                            )
                                          // If the employee doesn't have an image, display an empty person icon
                                          : const Icon(Icons.person, size: 100),
                                    ),
                                    // If the employee has an image, display it in a circular format

                                    // Display the employee's name
                                    Text(
                                      "${filteredUsers[index].fname} ${filteredUsers[index].lname}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      // If the snapshot doesn't have data, display a CircularProgressIndicator
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Usermodel>> fetchcuser(int id) async {
    final response = await http
        .get(Uri.parse('http://$ip/HrmPractise02/api/User/NewUserGet?id=$id'));

    var Data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      userlist.clear();

      if (Data is Map<String, dynamic>) {
        userlist.add(Usermodel.fromJson(Data));
      } else if (Data is List) {
        for (Map<String, dynamic> index in Data) {
          userlist.add(Usermodel.fromJson(index));
        }
      }

      return userlist;
    } else {
      return userlist;
    }
  }

  Future<List<Usermodel>> fetchcuserbyrole() async {
    //response keyword khud sa bnaya ha
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/User/UserroleGet')); // is ma aik variable bnaya ha response ka name sa or phir get method ka through api ko hit kar rahay hn is ka data aik data variable ma store karway ga
    var Data = jsonDecode(response.body
        .toString()); // decode kar ka data variable ma store kar rahay hn
    if (response.statusCode == 200) {
      userlistbyrole.clear();
      if (Data is Map<String, dynamic>) {
        userlistbyrole.add(Usermodel.fromJson(Data));
      } else if (Data is List) {
        for (Map<String, dynamic> index in Data) {
          userlistbyrole.add(Usermodel.fromJson(index));
        }
      }
      return userlistbyrole;
    } else {
      return userlistbyrole;
    }
  }

  //ya jo function bnaya ha is ka bgair attendance update nai ho sakti iska matlab ya ha ka current user jo chehckin huva uski id ka base pa get kar ka hum na on tap ma provide kiya card ka ontap ma

  // ignore: body_might_complete_normally_nullable
  Future<Attendancemodel?> fetchAttendanceByUid(int id) async {
    final response = await http.get(Uri.parse(
        'http://$ip/HrmPractise02/api/Attendance/AttendanceGet?uid=$id'));
    if (response.statusCode == 200) {
      var Data = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        attendancewithidlist.clear();

        if (Data is List<dynamic>) {
          for (Map<String, dynamic> index in Data) {
            attendancewithidlist.add(Attendancemodel.fromJson(index));
          }
          // Return the last attendance record if the list is not empty
          return attendancewithidlist.isNotEmpty
              ? attendancewithidlist.last
              : null;
        } else {
          print('Unexpected data format');
          return null;
        }
      } else {
        return null;
      }
    }
  }
}
