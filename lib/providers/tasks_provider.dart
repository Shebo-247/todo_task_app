import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../database/database_helper.dart';
import '../models/task_model.dart';

class TasksProvider with ChangeNotifier{

  DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Task> _allTasks;

  Future get tasksCount async{
    var result = await allTasks;
    return result.length;
  }

  Future get allTasks async{
    _allTasks = await _databaseHelper.getAllTasks();
    print(_allTasks.length);

    return _allTasks;
  }

  void addTask(Task task) async{
    int result = await _databaseHelper.addTask(task);
    _allTasks.add(task);
    notifyListeners();
  }

  void deleteTask(Task task) async{
    int result = await _databaseHelper.deleteTask(task.id);
    _allTasks.remove(task);
    notifyListeners();
  }

  void updateTask(Task task) async{
    int result = await _databaseHelper.updateTask(task);
    notifyListeners();
  }

}