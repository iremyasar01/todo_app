import 'package:todo_app/constants/task_type.dart';

class Task{
  Task({
    required this.type,
    required this.title,
    required this.description,
    required this.isCompleted,
  });
  //fonk olduğu için ; kullan.
  //bunları tanımlamam gerekli.
  final TaskType type;
  final String title;
  final String description;
   bool isCompleted;
}