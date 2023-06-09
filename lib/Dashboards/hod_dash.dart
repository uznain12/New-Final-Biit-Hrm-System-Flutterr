// ignore_for_file: prefer_const_constructors

import 'package:hrm_final_project/Applicant-Home/Personal/personal_info.dart';
import 'package:hrm_final_project/Employee-Home/Employee-Attendance/attendance.dart';
import 'package:hrm_final_project/Employee-Home/Employee-Committee/comittee_home.dart';
import 'package:hrm_final_project/Employee-Home/Employee-Leave/apply_for_leave.dart';
import 'package:hrm_final_project/Employee-Home/Employee-Leave/employee_all_leave_applications.dart';
import 'package:hrm_final_project/Hod-Home/job_applications.dart';
import 'package:hrm_final_project/Login-Signup/login.dart';
import 'package:hrm_final_project/Models/user_model.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class HodDashboard extends StatefulWidget {
  int? uid;
  HodDashboard({required this.uid});

  @override
  State<HodDashboard> createState() => _HodDashboardState();
}

List<Usermodel> userlist = [];

class _HodDashboardState extends State<HodDashboard> {
  @override
  void initState() {
    super.initState();
    fetchcuser(widget.uid!).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Welcome  ${userlist.isNotEmpty ? userlist[0].fname : ''} ${userlist.isNotEmpty ? userlist[0].lname : ''}",
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
                                image: NetworkImage(
                                    imagepath + userlist[0].image)),
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
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/background.jpg'),
                      fit: BoxFit.fill)),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.25),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HodSideJobApplications(
                                    uid: widget.uid,
                                  )));
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [Colors.grey.shade400, Colors.grey.shade200],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.work,
                              size: 60,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "ALL APPLICATIONS",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'RobotoSlab-VariableFont_wght'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
            )
          ],
        ));
  }
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
