import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:todo_task_app/providers/tasks_provider.dart';

import '../models/task_model.dart';

class DeleteTaskDialog extends StatefulWidget {
  final Task task;

  DeleteTaskDialog(this.task);

  @override
  _DeleteTaskDialogState createState() => _DeleteTaskDialogState();
}

class _DeleteTaskDialogState extends State<DeleteTaskDialog> {
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
              'Delete task',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              widget.task.title,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
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
                  child: Text('Delete'),
                  color: ThemeData().primaryColor,
                  onPressed: () {
                    tasksProvider.deleteTask(widget.task);
                    Toast.show('Task Deleted', context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
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