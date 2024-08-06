import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';



class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.task});
   final Todo task;
  

  @override
  State<TodoItem> createState() => _TodoItemState();
}


class _TodoItemState extends State<TodoItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.completed! ? Colors.grey : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('web/assets/images/Category.png')
            ,
            
          
            
             Expanded(
               child: Column(
                 children:[ Text(
                   widget.task.todo!,
                    style: TextStyle( //constu sil
                      decoration: widget.task.completed! ?
                      TextDecoration.lineThrough : TextDecoration.none ,
                      fontSize: 20, fontWeight: FontWeight.bold
                  ),
                  ),
                  //option+4
                  Text("user: ${widget.task.userId}"),

             ],
             ),
            ),
            Checkbox(
                value: isChecked,
                onChanged: (val) => {
                      setState(() {
                        widget.task.completed = !widget.task.completed!;
                        isChecked = val!;
                      })
                    }),
          ],
        ),
      ),
    );
  }
}
