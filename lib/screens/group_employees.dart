import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/app_db.dart';

class GroupEmployees extends StatefulWidget {
  @override
  State<GroupEmployees> createState() => _GroupEmployeesState();
}

class _GroupEmployeesState extends State<GroupEmployees> {
  final scrollController = ScrollController();
  int _currentPage = 1;
  int _offset = 2;
  int _limit = 10;

  @override
  void initState() {
    scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadMoreEmployees() async {
    _currentPage++;
    final moreEmployees = await Provider.of<AppDb>(context, listen: false)
        .limitEmployee(_limit, _limit * (_currentPage - 1));
  }

  Future<void> _scrollListener() async {
    _currentPage++;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print('call');
     //
    } else {
      print('is not calling');
    }

    print('scroll controller is called');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EmployeeData>>(
      future: Provider.of<AppDb>(context).limitEmployee(_limit, 2),
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
              padding: EdgeInsets.all(10),
              controller: scrollController,
              itemCount: employees.length + 1,
              itemBuilder: (context, index) {
                if (index == employees.length) {
                  return ElevatedButton(
                    onPressed: () => _loadMoreEmployees(),
                    child: Text('See More'),
                  );
                } else {
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
                }
              });
        }
        return Text('There are no data found');
      },
    );
    throw UnimplementedError();
  }
}
