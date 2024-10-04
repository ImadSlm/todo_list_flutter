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
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.orange,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("TO-DO LIST"),
              ),
              expandedHeight: 100,
            ),
            // SliverList(
            //   delegate:
            //       SliverChildBuilderDelegate((BuildContext context, int index) {
            //     
            //   }),
            // )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("ajouter une nouvelle tâche");
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
