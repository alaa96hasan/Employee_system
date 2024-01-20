import 'package:drift_db/data/app_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeStreamScreen extends StatefulWidget {
  const  EmployeeStreamScreen({super.key});

  @override
  State< EmployeeStreamScreen> createState() => _EmployeeStreamScreenState();
}

class _EmployeeStreamScreenState extends State< EmployeeStreamScreen> {

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
    return Scaffold(
  body: Container(
          height: 700,
          child: FutureBuilder<List<EmployeeData>>(
            future: Provider.of<AppDb>(context).getEmployees(),
            builder: (context, snapshot) {
              final List<EmployeeData>? employees = snapshot.data;
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (employees != null) {
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
              }
              return Text('There are no data found');
            },
          )),
    );
  }
}
