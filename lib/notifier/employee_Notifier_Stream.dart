import 'package:drift_db/data/app_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'employee_change_notifier.dart';

class EmployeeNotifierStreamScreen extends StatefulWidget {
  const EmployeeNotifierStreamScreen({super.key});

  @override
  State<EmployeeNotifierStreamScreen> createState() =>
      _EmployeeNotifierStreamScreenState();
}

class _EmployeeNotifierStreamScreenState
    extends State<EmployeeNotifierStreamScreen> {
  @override
  void initState() {
    super.initState();
    print('db_stream_initialized');
  }

  @override
  void dispose() {
    super.dispose();
    print('disposed');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Stream Build Contex');
    // final employees =
    //     context.watch<EmployeeChangeNotifier>().employeeListStream;
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Employee Stream',
              style: TextStyle(fontSize: 16, color: Colors.purple.shade900),
            ),
            backgroundColor: Colors.purple.shade50),
        body: Selector<EmployeeChangeNotifier, List<EmployeeData>>(
            selector: (context, notifier) => notifier.employeeListStream,
            builder: (context, employees, child) {
              debugPrint('Selector Build Contex');

              return ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/edit_employee',
                              arguments: employee.id);
                        },
                        child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.3,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  bottomRight: Radius.circular(16))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(employee.id.toString()),
                                Text(employee.userName.toString()),
                                Text(employee.firstName.toString()),
                                Text(employee.lastName.toString()),
                                Text(employee.birthDate.toString()),
                              ],
                            ),
                          ),
                        ));
                  });
            }));
  }
}
