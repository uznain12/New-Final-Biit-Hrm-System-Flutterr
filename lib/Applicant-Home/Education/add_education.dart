import 'package:flutter/material.dart';

import 'package:hrm_final_project/uri.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class AddEducation extends StatefulWidget {
  int? uid;
  AddEducation({super.key, required this.uid});
  // const AddEducation({super.key});

  @override
  State<AddEducation> createState() => _AddEducationState();
}

String? _selectedOption;
List<String> _options = [
  'Matric',
  'Inter',
  'Bachelor',
  'Master',
  'PHD',
]; // op

String? _selectinstitute;
List<String> _institutes = [
  'Bims University',
  'Priston University',
  'Iqra University',
  'Other',
]; // op

TextEditingController _instituteController = TextEditingController();
TextEditingController _boardController = TextEditingController();
TextEditingController _startDateController = TextEditingController();
TextEditingController _majorController = TextEditingController();
TextEditingController _endDateController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _AddEducationState extends State<AddEducation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Your Education"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.07,
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
                        "Degree",
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
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _majorController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.school_sharp),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 54,
                        minHeight: 54,
                      ),
                      labelText: 'Major',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Major';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // TextFormField(
                  //   controller: _instituteController,
                  //   decoration: const InputDecoration(
                  //     prefixIcon: Icon(Icons.school_sharp),
                  //     prefixIconConstraints: BoxConstraints(
                  //       minWidth: 54,
                  //       minHeight: 54,
                  //     ),
                  //     labelText: 'Institute',
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your Institute';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
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
                        "Institute",
                        style: TextStyle(fontSize: 20),
                      ),
                      isExpanded: true,
                      value: _selectinstitute,
                      items: _institutes.map((String option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectinstitute = newValue;
                        });

                        if (newValue == 'Other') {
                          _instituteController.text = '';
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Enter Other Institute'),
                                content: TextFormField(
                                  controller: _instituteController,
                                  decoration: const InputDecoration(
                                    labelText: 'Other Institute',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Save the entered value to the same column in the database
                                      _instituteController.text =
                                          _instituteController.text;
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a degree';
                        }
                        return null;
                      },
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // TextFormField(
                  //   controller: _majorController,
                  //   decoration: const InputDecoration(
                  //     prefixIcon: Icon(Icons.school_sharp),
                  //     prefixIconConstraints: BoxConstraints(
                  //       minWidth: 54,
                  //       minHeight: 54,
                  //     ),
                  //     labelText: 'Major',
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter Major';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _boardController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.school),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 54,
                        minHeight: 54,
                      ),
                      labelText: 'Board',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Board';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
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
                                lastDate: DateTime.now());
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
                                lastDate: DateTime.now());
                            if (picked != null) {
                              setState(() {
                                _endDateController.text =
                                    picked.toString().split(' ')[0];
                              });
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Passing Date',
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
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AddEducation(Uid: widget.uid);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }

  void AddEducation({int? Uid}) async {
    var url = "http://$ip/HrmPractise02/api/Education/EducationPost";
    var data = {
      "Uid": widget.uid,

      "Institute": _selectinstitute == 'Other'
          ? _instituteController.text
          : _selectinstitute,

      "Board": _boardController.text,
      "major": _majorController.text,
      "Startdate": _startDateController.text,
      "Enddate": _endDateController.text,
      "Degree": _selectedOption,
      "hasaddededucation": "true", // Change this to the appropriate value
    };
    var boddy = jsonEncode(data);
    var urlParse = Uri.parse(url);
    try {
      http.Response response = await http.post(urlParse,
          body: boddy, headers: {"Content-Type": "application/json"});
      var dataa = jsonDecode(response.body);
      print(dataa);
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
