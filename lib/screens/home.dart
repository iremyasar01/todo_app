import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/constants/task_type.dart';
import 'package:todo_app/screens/add_new_task.dart';
import 'package:todo_app/service/todo_service.dart';
import 'package:todo_app/todoitem.dart';
import 'package:todo_app/model/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 // List<String> todo = [
   // "Study Lesson",
  //  "Run 5k",
  //  "Go to party",
 //   "Meet your friends",
 //   "Go to gym",
 //   "Do Homework"
 // ];
 List <Task> todo = [
    Task(
      type: TaskType.calendar,
      title: "Study Lessons",
      description: "Study COMP-117 lessons",
      isCompleted: false,
    ),
    Task(
      type: TaskType.contest,
      title: "Run 5K",
      description: "Run 5K for today",
      isCompleted: false,
    ),
    Task(
      type: TaskType.note,
      title: "Go to party",
      description: "Attend to the party",
      isCompleted: false,
    ),
     Task(
      type: TaskType.calendar,
      title: "Meet your friends",
      description: "",
      isCompleted: false,
    ),
     Task(
      type: TaskType.contest,
      title: "Go to gym",
      description: "work out",
      isCompleted: false,
    ),
     Task(
      type: TaskType.calendar,
      title: "Do your homework",
      description: "DeadLine two days later",
      isCompleted: false,
    ),

  ];

  void addNewTask(Task newTask) {
    setState(() {
      todo.add(newTask);
    });
  }
  List<String> completed = [
    "Game meetup",
    "take out trash",
    "take the pill",
    "cry",
    "go to sleep",
    "brush your teeth"
  ];
  @override
  Widget build(BuildContext context) {
   TodoService todoService = TodoService();
  
    //responsive design
    //her telde aynı size'a sahip olsunlar diye.
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        //mobildeki bildirim paneli gözükmesin diye.
        child: Scaffold(
            backgroundColor: HexColor(backgroundColor),
            body: Column(
              children: [
                Container(
                  //header
                  height: deviceHeight / 4,
                  //hangi ekranda olursa olsun ekranın 3te biri kadar yer kaplasın.
                  width: deviceWidth,

                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    image: DecorationImage(
                        image: AssetImage("web/assets/images/header.png"),
                        fit: BoxFit.cover //ayırdığım alanı kapla.
                        ),
                  ),
                  //iki satır biri tarih biri başlık
                  child: const Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text("Date",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))),
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          "My Todo List",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                //Top Column
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
                    child: SingleChildScrollView(
                      //FutureBuilder: bir servis tarafından veri çekilip snapshotunu almamızı sağlar.
                      //snapshot: veriyi çektiğim zamanki görüntüsü.
                      child: FutureBuilder(
                        future: todoService.getUncompletedTodos(),//snapshotunu bu metotdan al.
                        builder: (context ,snapshot){
                          if(snapshot.data == null){
                            return const CircularProgressIndicator(); //loading simgesi

                          }
                          else{
                               return ListView.builder(
                        primary:
                            false, //singleChildScrollView olana alsın list olarak değil.
                        shrinkWrap:
                            true, //kendisine tahsis edilen kadar alan kullansın diye.
                        itemCount: snapshot.data?.length,//data varsa onun uzunluğunu al.
                        itemBuilder: (context, index) {
                          return TodoItem(task: snapshot.data![index]);
                        },
                      );
                          }
                       
                        },),
                    ),
                  ),
                ),
                //completed
                
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: SingleChildScrollView(
                          child: FutureBuilder(
                        future: todoService.getcompletedTodos(),//snapshotunu bu metotdan al.
                        builder: (context ,snapshot){
                          if(snapshot.data == null){
                            return const CircularProgressIndicator(); //loading simgesi

                          }
                          else{
                               return ListView.builder(
                        primary:
                            false, //singleChildScrollView olana alsın list olarak değil.
                        shrinkWrap:
                            true, //kendisine tahsis edilen kadar alan kullansın diye.
                        itemCount: snapshot.data?.length,//data varsa onun uzunluğunu al.
                        itemBuilder: (context, index) {
                          return TodoItem(task: snapshot.data![index]
                        );
                        },
                      );
                   }
                       
                        },
                        ),
                ),
                  ),
                ),

                //Bottom Column
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: 
                    (context)=>  AddNewTaskScreen(
                    addNewTask: (newTask) => addNewTask(newTask),

                    ),
                    ));
                  },
                  child: const Text("add new task"),
                )
              ],
            )),
      ),
    );
  }
}
