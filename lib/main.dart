import 'package:flutter/material.dart';
import 'package:todo_app/screens/home.dart';


void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
 const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}


class _TodoAppState extends State<TodoApp> {
    
  @override
  Widget build(BuildContext context) {

 
    return const MaterialApp(
      //debug label'ini kaldırmak için.
       debugShowCheckedModeBanner: false,
      home: HomeScreen(),
     
    );
   }
}