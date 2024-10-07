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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "TO-DO LIST",
          style: TextStyle(fontSize: 35),
        )),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration:
                  InputDecoration(labelText: "Entrez une nouvelle tâche"),
              controller: _taskController,
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                print('${_taskController.text}');
                _taskController.clear();
              },
              child: Icon(Icons.add_task),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
