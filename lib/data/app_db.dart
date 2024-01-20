import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:drift_db/data/employee_table.dart';

part 'app_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'employee.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Employee])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<EmployeeData>> getEmployees() async {
    return await select(employee).get();
  }

  Stream<List<EmployeeData>> getEmployeeStream() {
    return select(employee).watch();
  }

  Future<List<EmployeeData>> limitEmployee(int limit, int offset) async {
    return await (select(employee)..limit(limit, offset: offset)).get();
  }

  Future<EmployeeData> getEmployee(int id) async {
    return (select(employee)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<bool> updateEmployee(EmployeeCompanion entity) async {
    return await update(employee).replace(entity);
  }

  Future<int> insertEmployee(EmployeeCompanion entity) async {
    return await into(employee).insert(entity);
  }

  Future deleteEmployee(int id) async {
    return  (delete(employee)..where((tbl) => tbl.id.equals(id))).go;
  }
}
