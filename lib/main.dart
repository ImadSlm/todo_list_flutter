// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_string_interpolations, library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-Do List",
      home: TDLInterface(),
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

  void _addTask() {
    String newTask = _taskController.text;
    if (newTask.isNotEmpty) {
      setState(() {
        tasks.add(newTask);
      });
      _taskController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
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
            taskList(),
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
                child: taskEntry(),
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

  Expanded taskList() {
    return Expanded(
      child: tasks.isEmpty
          ? Text("Votre liste est vide")
          : ListView.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(tasks[index]),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment(0.75, 0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    String removedTask = tasks[index];
                    setState(() {
                      tasks.removeAt(index);
                    });
                    final sb = SnackBar(
                      content: Text("$removedTask supprimé"),
                      action: SnackBarAction(
                          label: "Annuler",
                          onPressed: () {
                            setState(() {
                              tasks.insert(index, removedTask);
                            });
                          }),
                      duration: Duration(seconds: 5),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(sb);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: ListTile(
                      title: Text(
                        "${tasks[index]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: tasks.length,
            ),
    );
  }

  Column taskEntry() {
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
          onPressed: _addTask,
          child: Icon(Icons.add_task),
        ),
      ],
    );
  }
}
