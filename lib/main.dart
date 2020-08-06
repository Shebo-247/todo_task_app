import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task_app/pages/home_page.dart';
import 'package:todo_task_app/providers/tasks_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksProvider>(
      create: (_)=> TasksProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'RobotoRegular',
        ),
        home: HomePage(),
      ),
    );
  }
}
