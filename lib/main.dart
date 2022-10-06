import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/home.dart';
import 'package:todoapp/todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'Home',
      routes: {
        'Home':(context) => HomePage(),
        'Todos':(context) => TodoApp(),
      },
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      home: HomePage(),
    );
  }
}

