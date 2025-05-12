import 'package:flutter/material.dart';
import 'database.dart';
import 'package:drift/drift.dart' as drift;
import 'TodoListPage.dart';

void main() {
  final database = AppDatabase();
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drift Todo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoListPage(database: database),
    );
  }
}

