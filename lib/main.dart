import 'package:check_list_app/screens/home.dart';
import 'package:check_list_app/screens/tasks.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CheckListApp());
}

class CheckListApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Check List App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Home(),
    );
  }
}
