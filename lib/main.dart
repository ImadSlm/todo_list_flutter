// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_string_interpolations, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './task_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        title: "To-Do List",
        home: TDLInterface(),
      ),
    );
  }
}

class TDLInterface extends StatefulWidget {
  const TDLInterface({
    super.key,
  });

  @override
  _TDLInterfaceState createState() => _TDLInterfaceState();
}

class _TDLInterfaceState extends State<TDLInterface> {
  final TextEditingController _taskController = TextEditingController();
  List<String> tasks = [];
  bool _isTextFieldVisible = true;

  void _addTask(TaskProvider _taskProvider) {
    String newTask = _taskController.text;
    if (newTask.isNotEmpty) {
      setState(() {
        _taskProvider.addTask(newTask);
      });
      _taskController.clear();
    }
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              Icon(Icons.list_alt),
              Text(
                "TO-DO LIST",
                style: TextStyle(fontSize: 35),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Text(
                "Liste : ",
                style: TextStyle(
                  fontSize: 20,
                ),
                textDirection: TextDirection.ltr,
              ),
            ),
            buildTaskList(_taskProvider),
            if (_isTextFieldVisible)
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 3,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
                child: taskEntry(_taskProvider),
              ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      floatingActionButton: floatingBtn(),
    );
  }

  FloatingActionButton floatingBtn() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          _isTextFieldVisible = !_isTextFieldVisible;
        });
      },
      child: Icon(_isTextFieldVisible ? Icons.close : Icons.add),
    );
  }

  Expanded buildTaskList(TaskProvider _taskProvider) {
    void _removeTask(Task task) {
      setState(() {
        _taskProvider.removeTask(task);
      });
      final sbDeleted = SnackBar(
        content: Text("${task.title} supprimée"),
        action: SnackBarAction(
            label: "Annuler",
            onPressed: () {
              setState(() {
                _taskProvider.addTask(task.title);
              });
            }),
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(sbDeleted);
    }

    return Expanded(
      child: _taskProvider.tasks.isEmpty
          ? Text("Votre liste est vide")
          : ListView.builder(
              itemBuilder: (context, index) {
                final task = _taskProvider.tasks[index];
                return Dismissible(
                  key: Key(task.title),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment(0.75, 0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    _removeTask(task);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      tileColor: task.isDone ? Colors.lightGreen : Colors.white,
                      trailing: Checkbox(
                        value: task.isDone,
                        onChanged: (value) {
                          _taskProvider.taskFinished(task);
                          final sbDone = SnackBar(
                            content: Text("${task.title} terminée"),
                            duration: Duration(seconds: 1),
                          );
                          task.isDone
                              ? ScaffoldMessenger.of(context)
                                  .showSnackBar(sbDone)
                              : null;
                        },
                      ),
                    ),
                  ),
                );
              },
              itemCount: _taskProvider.tasks.length,
            ),
    );
  }

  Column taskEntry(TaskProvider _taskProvider) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: "Entrez une nouvelle tâche"),
          controller: _taskController,
        ),
        SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: () {
            if (_taskController.text.isNotEmpty) {
              _taskProvider.addTask(_taskController.text);
              _taskController.clear();
            }
          },
          child: Icon(Icons.add_task),
        ),
      ],
    );
  }
}
