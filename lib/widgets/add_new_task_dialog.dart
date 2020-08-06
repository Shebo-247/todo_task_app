import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:todo_task_app/providers/tasks_provider.dart';

import '../models/task_model.dart';

class AddNewTaskDialog extends StatefulWidget {
  @override
  _AddNewTaskDialogState createState() => _AddNewTaskDialogState();
}

class _AddNewTaskDialogState extends State<AddNewTaskDialog> {

  TextEditingController _titleController;

  String _selectedDate = 'Pick a date';

  Future _showDatePicker() async{
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(Duration(days: -365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((date) => setState(()=> _selectedDate = DateFormat('dd-MM-yyyy').format(date)));
  }

  @override
  void initState() {
    super.initState();
    
    _titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Add new task',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'eg. Playing Football',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () => _showDatePicker(),
                  icon: Icon(
                    Icons.date_range,
                    size: 25,
                    color: ThemeData().primaryColor,
                  ),
                ),
                SizedBox(width: 10),
                Text(_selectedDate),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text('Cancel'),
                  color: Colors.redAccent,
                  onPressed: () => Navigator.pop(context),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text('Save'),
                  color: ThemeData().primaryColor,
                  onPressed: () {
                    String title = _titleController.value.text;
                    String date = _selectedDate;

                    if (title.isNotEmpty && date != 'Pick a date') {
                      Task task = Task(title, date, 0);
                      tasksProvider.addTask(task);
                      _titleController.clear();
                      Toast.show('Task Added', context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
                    } else {
                      Toast.show('Data Invalid ! Try fill all fields', context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}