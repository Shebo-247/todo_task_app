import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_task_app/database/database_helper.dart';
import 'package:todo_task_app/models/task_model.dart';
import 'package:todo_task_app/pages/about_page.dart';
import 'package:todo_task_app/providers/tasks_provider.dart';
import 'package:todo_task_app/widgets/add_new_task_dialog.dart';
import 'package:todo_task_app/widgets/delete_task_dialog.dart';
import 'package:todo_task_app/widgets/update_task_dialog.dart';

DatabaseHelper helper = DatabaseHelper();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isClicked = false;

  List<String> menuButtons = ['About App'];

  Widget _buildTask(Task task) {
    return GestureDetector(
      onTap: () => showDialog(
        barrierDismissible: false,
        context: context,
        child: UpdateTaskDialog(task),
      ),
      onLongPress: () => showDialog(
        barrierDismissible: false,
        context: context,
        child: DeleteTaskDialog(task),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Card(
          elevation: 5,
          margin: EdgeInsets.only(bottom: 15),
          child: ListTile(
            leading: Checkbox(
              activeColor: Colors.white60,
              checkColor: Colors.blueAccent,
              value: task.isCompleted == 1,
              onChanged: (value) {
                print(value);
                markTaskAsCompleted(task);
              },
            ),
            title: Text(
              task.title,
              style: TextStyle(
                fontSize: 18,
                decoration: task.isCompleted == 1
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: Text(
              task.date,
              style: TextStyle(
                fontSize: 14,
                decoration: task.isCompleted == 1
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  markTaskAsCompleted(Task task) async {
    if (task.isCompleted == 0)
      task.setComplete(1);
    else
      task.setComplete(0);

    int result = await helper.updateTask(task);

    setState(() => print('Task updated'));
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    return Scaffold(
      backgroundColor: ThemeData().primaryColor,
      appBar: AppBar(
        title: Text('TODO Daily'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.timeline, size: 30),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AboutPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: tasksProvider.allTasks,
        builder: (_, snapshot) {
          return Column(
            children: <Widget>[
              // Create the top side of the app
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'My Tasks',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        snapshot.hasData
                            ? Text(
                                '${snapshot.data.length} Tasks',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white54,
                                  fontFamily: 'RobotoLight',
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    MaterialButton(
                      onPressed: () => showDialog(
                        barrierDismissible: false,
                        context: context,
                        child: AddNewTaskDialog(),
                      ),
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Text(
                        'Add New',
                        style: TextStyle(
                          color: ThemeData().primaryColor,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ],
                ),
              ),

              // Create the main area of the app that contain tasks
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 212,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                  ),
                ),
                child: snapshot.hasData
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return _buildTask(snapshot.data[index]);
                        },
                      )
                    : Container(
                        child: Center(child: Text('No Tasks yet')),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
