import 'package:flutter/material.dart';

class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  List<Task> get tasks => _tasks ;

  void addTask(String taskTitle){
    _tasks.add(Task(title: taskTitle));
    notifyListeners();
  }

  void removeTask(Task task){
    _tasks.remove(task);
    notifyListeners();
  }

  void taskFinished(Task task){
    task.isDone = !task.isDone;
    notifyListeners();
  }
}
