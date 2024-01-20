import 'package:drift_db/data/app_db.dart';
import 'package:drift_db/notifier/employee_change_notifier.dart';
import 'package:drift_db/router/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: AppDb()),
        ChangeNotifierProxyProvider<AppDb, EmployeeChangeNotifier>(
            create: (context) => EmployeeChangeNotifier(),
            update: (context, db, notifier) => notifier!
              ..initAppDb(db)
              ..getEmployeeFuture())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
