import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import './task_tile.dart';
import '../models/task_data.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemCount: taskData.taskCount,
          itemBuilder: (BuildContext context, int index) {
            final task = taskData.tasks[index];
            return TaskTile(
              taskTitle: task.name,
              isChecked: task.isDone,
              checkBoxCallBack: (bool checkBoxState) {
                taskData.updateTask(task);
              },
              longPressCallBack: () {
                showAlert(context, taskData, task);
              },
            );
          },
        );
      },
    );
  }
}

void showAlert(context, taskData, task) {
  Alert(
    context: context,
    type: AlertType.none,
    title: "Delete Task?",
    desc: "Are you sure?",
    buttons: [
      DialogButton(
        child: Text(
          "Yes",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          taskData.deleteTask(task);
          Navigator.pop(context);
        },
        color: Colors.lightBlueAccent,
      ),
      DialogButton(
        child: Text(
          "No",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        color: Colors.red,
      )
    ],
  ).show();
}
