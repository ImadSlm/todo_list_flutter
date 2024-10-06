// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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

class TDLInterface extends StatelessWidget {
  const TDLInterface({
    super.key,
  });

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
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Entrez une nouvelle tâche"),
            controller: null,
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Icon(Icons.add_task),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("ajouter une nouvelle tâche");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
