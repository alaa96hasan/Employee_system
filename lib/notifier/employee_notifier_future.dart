import 'package:drift_db/data/app_db.dart';
import 'package:drift_db/notifier/employee_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeNotifierFutureScreen extends StatefulWidget {
  const EmployeeNotifierFutureScreen({super.key});

  @override
  State<EmployeeNotifierFutureScreen> createState() =>
      _EmployeeNotifierFutureScreenState();
}

class _EmployeeNotifierFutureScreenState
    extends State<EmployeeNotifierFutureScreen> {
  @override
  void initState() {
    super.initState();
    print('db_future_initialized');
  }

  @override
  void dispose() {
    super.dispose();
    print('disposed');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('BuildContext');

    final isLoading = context
        .select<EmployeeChangeNotifier, bool>((notifier) => notifier.isLoading);

    return Scaffold(
        appBar: AppBar(elevation: 20,
          title: Text('Employee Future',
            style: TextStyle(fontSize: 16,
                color: Colors.purple.shade900),),
            backgroundColor: Colors.purple.shade50
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<EmployeeChangeNotifier>(
                builder: (context, notifier, child) {
                  debugPrint(' Consumer widget ');
                return ListView.builder(
                    itemCount: notifier.employeeListFuture.length,
                    itemBuilder: (context, index) {
                      final employee = notifier.employeeListFuture[index];
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
