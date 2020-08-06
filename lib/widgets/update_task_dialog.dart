import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:todo_task_app/providers/tasks_provider.dart';

import '../models/task_model.dart';

class UpdateTaskDialog extends StatefulWidget {

  final Task task; 

  UpdateTaskDialog(this.task);

  @override
  _UpdateTaskDialogState createState() => _UpdateTaskDialogState();
}

class _UpdateTaskDialogState extends State<UpdateTaskDialog> {

  TextEditingController _updatedTitleController;

  String _selectedDate;

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

    _updatedTitleController = TextEditingController();
    _updatedTitleController.text = widget.task.title;
    _selectedDate = widget.task.date;
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
              'Updating your task',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _updatedTitleController,
              decoration: InputDecoration(
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
                  child: Text('Update'),
                  color: ThemeData().primaryColor,
                  onPressed: () {
                    widget.task.setTitle(_updatedTitleController.value.text);
                    widget.task.setDate(_selectedDate);
                    tasksProvider.updateTask(widget.task);
                    Toast.show('Task Updated', context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
                    Navigator.pop(context);
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