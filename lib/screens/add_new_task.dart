import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/constants/task_type.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/todo_service.dart';


class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, required this.addNewTask});
  final void Function(Task newTask) addNewTask;
  //passing function as parameter

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
TextEditingController titleController = TextEditingController();
TextEditingController userIdController = TextEditingController();
TextEditingController timeController = TextEditingController();
TextEditingController descriptionController = TextEditingController();


TodoService todoService = TodoService();

TaskType taskType = TaskType.note;

  @override
  Widget build(BuildContext context) {
    //responsive design
    //bunları buraya da alıyorum çünkü her widgetın contexti kendine özgü. ondan global yapamıyorum.
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        //navigatordan buraya geldiğimizi bildiği için otomatik geri tuşu ekliyo.
        //appBar: AppBar(),
        backgroundColor: HexColor(backgroundColor),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: deviceWidth,
                  height: deviceHeight / 10,
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    image: DecorationImage(
                        image: AssetImage(
                            "web/assets/images/add_new_task_header.png"),
                        fit: BoxFit.cover),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          //önceki sayfaya geri dönsün diye
                          //mantığı listedeki en sondakini pop etmek.
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const Expanded(
                          child: Text(
                        "Add New Task",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ))
                    ],
                  )),
              const Padding(
                  padding: EdgeInsets.only(top: 20), child: Text("Text Title")),
               Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: TextField(
                    controller: titleController,
                    decoration:
                       const InputDecoration(filled: true, fillColor: Colors.white),
                  )), //input alan
               Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Category"),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 300),
                            //textin ne kadar süre kalacağını belirliyo.
                            content: Text("Category selected"),
                          ),
                          //en aşağıya uyarı veriyo.
                        );
                        setState(() {
                          taskType = TaskType.note;
                        });
                      },
                      child: Image.asset(
                        ("web/assets/images/Category.png"),
                      ),
                      //dokunmayı kontrol eden.
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 300),
                            //textin ne kadar süre kalacağını belirliyo.
                            content: Text("Category selected"),
                          ),
                          //en aşağıya uyarı veriyo.
                        );
                         setState(() {
                          taskType = TaskType.calendar;
                        });
                      },
                      child: Image.asset(
                        ("web/assets/images/Category_2.png"),
                      ),
                      //dokunmayı kontrol eden.
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 300),
                            //textin ne kadar süre kalacağını belirliyo.
                            content: Text("Category selected"),
                          ),
                          //en aşağıya uyarı veriyo.
                        );
                         setState(() {
                          taskType = TaskType.contest;
                        });
                      },
                      child: Image.asset(
                        ("web/assets/images/Category_3.png"),
                      ),
                      //dokunmayı kontrol eden.
                    ),
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                         const Text("userId"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: userIdController,
                              decoration:  const InputDecoration(
                                  filled: true, fillColor: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                         const Text("Time"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: timeController,
                            decoration: const InputDecoration(
                                filled: true, fillColor: Colors.white),
                          ),
                        )
                      ],
                    )),
                  ],
                ),
              ),
             const Padding(
                padding: EdgeInsets.only(top:20),
                child: Text("Descriptions")),
               SizedBox(
                height: 250,
                child: TextField(
                  controller: descriptionController,
                  expands: true, //yazdıkça genişlesin.
                  maxLines: null, //max bir değeri yok
                  decoration:
                     const InputDecoration(filled: true, fillColor: Colors.white, isDense: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:25),
                child: ElevatedButton(onPressed: (){
                  saveTodo();
                //  Task newTask = Task(type: taskType, title: titleController.text, description: descriptionController.text, isCompleted: false
               // );
                //widget.addNewTask(newTask);
                Navigator.pop(context);
                },
                 child: const Text("save")))
            ],
          ),
        ),
      ),
    );
  }
    void saveTodo(){
      Todo newTodo = Todo(
      id: -1, //önemi yok
      todo: titleController.text,
      completed: false,
      userId: int.parse(userIdController.text),
    );
    todoService.addTodo(newTodo);
    }
    }//Fonklar ; ile bitiyor diğerleri , ile.
  

