import 'package:drift_db/screens/add_employee_screen.dart';
import 'package:drift_db/screens/my_home_page.dart';
import 'package:drift_db/screens/group_employees.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drift_db/screens/edit_employee_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MyHomePage());
      case '/add_employee':
        return MaterialPageRoute(builder: (_) => AddEmployeeScreen());
      case '/group_employees':
        return MaterialPageRoute(builder: (_) => GroupEmployees());
      case '/edit_employee':
        if (args is int) {
          return MaterialPageRoute(
              builder: (_) => EditEmployeeScreen(
                    id: args,
                  ));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('No Route'),
        ),
        body: Center(child: Text('Sorry, No route was found!!')),
      );
    });
  }
}
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AddEmployeeScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}