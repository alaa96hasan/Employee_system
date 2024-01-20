import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/app_db.dart';

class GroupEmployees extends StatefulWidget {
  @override
  State<GroupEmployees> createState() => _GroupEmployeesState();
}

class _GroupEmployeesState extends State<GroupEmployees> {
  final scrollController=ScrollController();
  int _currentPage = 1;
  int _offset = 2;
  int _limit = 10;
  bool isLoadingMore=false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMoreEmployees);
  }

  @override
  void dispose() {
    super.dispose();
  }
  Future<void> _loadMoreEmployees() async {
    if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
      setState(() {
        isLoadingMore= true;
      });

      _currentPage++;
      await   Provider.of<AppDb>(context,listen: false).limitEmployee(_limit, _limit * (_currentPage - 1));
      setState(() {
        isLoadingMore = false;
      });
    }}
  @override
  Widget build(BuildContext context) {




    return FutureBuilder<List<EmployeeData>>(
      future:   Provider.of<AppDb>(context).limitEmployee(_limit, _offset),
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
              itemCount: isLoadingMore ? employees.length + 1 : employees.length,
              itemBuilder: (context, index) {
                if (index < employees.length) {
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
                    ));}
                else      Center (child: CircularProgressIndicator(),);
              }
                );
        }
        return Text('There are no data found');
      },
    );
    throw UnimplementedError();
  }
}
