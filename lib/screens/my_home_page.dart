import 'package:drift_db/notifier/employee_change_notifier.dart';
import 'package:drift_db/notifier/employee_Notifier_Stream.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifier/employee_notifier_future.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index=0;
  final pages=[
    EmployeeNotifierFutureScreen(),
    EmployeeNotifierStreamScreen()
  ];
  @override
  void initState() {
    super.initState();
    print('Screen_home_initialized');

  }

  @override
  void dispose() {
    super.dispose();
    print('disposed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text(
              'Groups',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/group_employees');
            },
          ),
        ],
        backgroundColor: Colors.purple.shade100,
        title: Text('Home',style: TextStyle(fontSize: 24,color: Colors.purple.shade900),),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.person_add_alt),
        label: Text("Add Employee"),
        onPressed: () {
          Navigator.pushNamed(context, '/add_employee');
        },
      ),
      bottomNavigationBar: BottomNavigationBar(

        currentIndex:index ,
        onTap: (value){
          if (value==1){
            context.read<EmployeeChangeNotifier>().getEmployeeStream();
          }
          setState(() {
            index=value;
          });
        },
        items: [
          BottomNavigationBarItem(label: "Future Emp",
              icon: Icon(Icons.list),
              activeIcon: Icon(Icons.list_alt_outlined)),
          BottomNavigationBarItem(label: "Stream Emp",
              icon: Icon(Icons.list), activeIcon: Icon(Icons.list_alt_outlined))
        ],
      ),
      body:pages[index],

    );
  }
}
