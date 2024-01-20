import 'dart:core';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:provider/provider.dart';
import '../data/app_db.dart' as database;
import 'package:intl/intl.dart';
import '../data/app_db.dart';
import '../notifier/employee_change_notifier.dart';

class EditEmployeeScreen extends StatefulWidget {
  final int id;

  const EditEmployeeScreen({required this.id, super.key});

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  late database.EmployeeData _employeeData;
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  late DateTime _dateOfBirth;
  late EmployeeChangeNotifier _employeeChangeNotifier;

  @override
  void initState() {
    super.initState();
    getEmployee();
    print('db_edit_initialized');
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
    //_employeeChangeNotifier.dispose();
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
      appBar: AppBar( backgroundColor: Colors.purple.shade50,
        title: Center(child: Text('Edit Employee',style: TextStyle(fontSize: 16,
            color: Colors.purple.shade900),))

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
                  maxLines: 1,
                  autocorrect: true,
                  keyboardAppearance: Brightness.light,
                  enableSuggestions: true,
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
                          Colors.purple.shade200),
                    ),
                    onPressed: () {
                      print('will update employee');
                      editEmployee();
                      print("Employee's updated");
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: width,
                  child: IconButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.purple.shade100),
                    ),
                    onPressed: () {
                      print('will delete the employee');
                      deleteEmployee();
                      print('the employee deleted ');
                    },
                    icon: Icon(Icons.delete),
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

  void editEmployee() {
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      final entity = EmployeeCompanion(
        id: drift.Value(widget.id),
        userName: drift.Value(_userNameController.text),
        firstName: drift.Value(_firstNameController.text),
        lastName: drift.Value(_lastNameController.text),
        birthDate: drift.Value(_dateOfBirth!),
      );
      context.read<EmployeeChangeNotifier>().updateEmployee(entity);

    }
  }

  Future<void> getEmployee() async {
    _employeeData =
        await Provider.of<AppDb>(context, listen: false).getEmployee(widget.id);
    _userNameController.text = _employeeData.userName;
    _firstNameController.text = _employeeData.firstName;
    _lastNameController.text = _employeeData.lastName;
    _dateOfBirthController.text = _employeeData.birthDate.toIso8601String();
  }

  void deleteEmployee() {
    context.read<EmployeeChangeNotifier>().deleteEmployee(widget.id);

  }

  void providerListener() {
    if (_employeeChangeNotifier.isUpdated) {
      listenUpdate();
    }
    if (_employeeChangeNotifier.isDeleted) {
      listenDelete();
    }
  }

  void listenUpdate() {
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
        backgroundColor: Colors.purple.shade200,
        content: Text(' Employee updated '),
        actions: [
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: Text('OK'),
          )
        ]));
  }

  void listenDelete() {
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
        backgroundColor: Colors.purple.shade200,
        content: Text('Employee deleted '),
        actions: [
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: Text('OK'),
          )
        ]));
  }
}
