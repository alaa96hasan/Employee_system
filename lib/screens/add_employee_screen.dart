import 'dart:core';

import 'package:drift_db/notifier/employee_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:provider/provider.dart';
import '../data/app_db.dart';
import 'package:intl/intl.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  late DateTime _dateOfBirth;
  late EmployeeChangeNotifier _employeeChangeNotifier;

  @override
  void initState() {
    super.initState();
    print('db_add_initialized');
    _employeeChangeNotifier =
        Provider.of<EmployeeChangeNotifier>(context, listen: false);
    _employeeChangeNotifier.addListener(providerListener);
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dateOfBirthController.dispose();
    _employeeChangeNotifier.dispose();

    super.dispose();
  }

  Future<void> pickDateOfBirth() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (newDate != null) {
      _dateOfBirth = newDate;
      String dob = DateFormat('dd/mm/yyyy').format(newDate);
      _dateOfBirthController.text = dob;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple.shade50,
        title: Center(child: Text('New Employee',style: TextStyle(fontSize: 16,
            color: Colors.purple.shade900),)),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusColor: Colors.orange.shade100,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(15)),
                    hintText: 'Enter your user name please',
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.black45),
                    helperStyle: TextStyle(fontSize: 15),
                    prefixIcon: FittedBox(
                      fit: BoxFit.none,
                      child: Icon(Icons.person),
                    ),
                    prefixIconColor: Colors.black54,
                  ),
                  cursorColor: Colors.purple,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 10,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your user name';
                    }
                    if (val.length < 3) {
                      return 'Pass should be min 3 chars';
                    }
                    return null;
                  },
                  controller: _userNameController,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusColor: Colors.orange.shade100,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(15)),
                    hintText: 'Enter your first name please',
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.black45),
                    helperStyle: TextStyle(fontSize: 15),
                    prefixIcon: FittedBox(
                      fit: BoxFit.none,
                      child: Icon(Icons.person_2),
                    ),
                    prefixIconColor: Colors.black54,
                  ),
                  cursorColor: Colors.purple,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 10,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your last name';
                    }
                    if (val.length < 3) {
                      return 'last name should be min 3 chars';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusColor: Colors.orange.shade100,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(15)),
                    hintText: 'Enter your last name please',
                    labelText: 'Last Name',
                    labelStyle: TextStyle(color: Colors.black45),
                    helperStyle: TextStyle(fontSize: 15),
                    prefixIcon: FittedBox(
                      fit: BoxFit.none,
                      child: Icon(Icons.person_2),
                    ),
                    prefixIconColor: Colors.black54,
                  ),
                  cursorColor: Colors.purple,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 10,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your last name';
                    }
                    if (val.length < 3) {
                      return 'last name should be min 5 chars';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onTap: pickDateOfBirth,
                  controller: _dateOfBirthController,
                  decoration: InputDecoration(
                      focusColor: Colors.orange.shade100,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'Enter your birth date please',
                      labelText: 'BirthDate',
                      labelStyle: TextStyle(color: Colors.black45),
                      helperStyle: TextStyle(fontSize: 15),
                      prefixIcon: IconButton(
                          icon: Icon(Icons.calendar_month), onPressed: () {}),
                      prefixIconColor: Colors.black54,
                      suffixIcon: IconButton(
                          icon: Icon(Icons.date_range),
                          onPressed: () => _dateOfBirthController.clear()),
                      suffixIconColor: Colors.black38), //validator:
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: width,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.purple.shade100),
                    ),
                    onPressed: () {
                      print('will add a new employee');
                      addEmployee();
                      print('A new employee added');
                    },
                    child: Text(
                      'Insert',
                      style: TextStyle(fontSize: 16,
                          color: Colors.purple.shade900),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
    throw UnimplementedError();
  }

  void addEmployee() {
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      final entity = EmployeeCompanion(
        userName: drift.Value(_userNameController.text),
        firstName: drift.Value(_firstNameController.text),
        lastName: drift.Value(_lastNameController.text),
        birthDate: drift.Value(_dateOfBirth),
      );
      context.read<EmployeeChangeNotifier>().createEmployee(entity);
      // Provider.of<AppDb>(context, listen: false).insertEmployee(entity).then(
      //         (value) => ScaffoldMessenger.of(context).showMaterialBanner(
      //         MaterialBanner(
      //             backgroundColor: Colors.purple.shade200,
      //             content: Text('New Employee inserted $value'),
      //             actions: [
      //               TextButton(
      //                 onPressed: () => ScaffoldMessenger.of(context)
      //                     .hideCurrentMaterialBanner(),
      //                 child: Text('OK'),
      //               )
      //             ])));
    }
  }

  void providerListener() {
    if (_employeeChangeNotifier.isAdded) {
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          backgroundColor: Colors.purple.shade200,
          content: Text('New Employee inserted '),
          actions: [
            TextButton(
              onPressed: () =>
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
              child: Text('OK'),
            )
          ]));
    }
  }
}
