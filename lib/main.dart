import 'package:check_list_app/data/moorDatabase.dart';
import 'package:check_list_app/screens/home.dart';
import 'package:check_list_app/screens/tasks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(CheckListApp());
}

class CheckListApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider(
      create:(_) => AppDatabase(),
      child:  MaterialApp(
          title: 'Check List App',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: Home(),
      )
    );
  }
}
