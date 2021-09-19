
import 'package:check_list_app/components/bottomButtonBar.dart';
import 'package:check_list_app/components/customAlertBox.dart';
import 'package:check_list_app/components/customAppbar.dart';
import 'package:check_list_app/data/moorDatabase.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';
class TasksScreen extends StatefulWidget {
  final int checkListId;
  final String checkListName;
  const TasksScreen({required this.checkListId, required this.checkListName});
  @override
  TasksScreenState createState() => TasksScreenState();
}

class TasksScreenState extends State<TasksScreen> {


  deleteTasks(BuildContext context) {
    final database = Provider.of<AppDatabase>(context, listen: false);
    final tasksDao = database.tasksDao;

    showDialog(context: context, builder: (context)=>
      AlertDialog(  
        title: Text("ATTENTION!"),  
        content: Text("Are you sure you want to delete all tasks?"),  
        actions: [  
          TextButton(
            onPressed: ()=>{
              tasksDao.deleteTasks(widget.checkListId),
              Navigator.of(context).pop()
            }, 
          child: Text("Ok")),  
        ],  
      )
    );  

    
  }

  addTask(BuildContext context, String toDo, DateTime createdAt){
    print('[toDo, createdAt]=======>${[toDo, createdAt]}');
    final database = Provider.of<AppDatabase>(context, listen: false);
    final tasksDao = database.tasksDao;
    final TasksCompanion task = TasksCompanion.insert(checkListId: widget.checkListId, toDo: toDo, createdAt: Value.ofNullable(createdAt));
    tasksDao.insertTask(task);
  }

  showInputDialog(BuildContext context){
    return showDialog(context: context, builder: (context)=>CustomAlertBox(title: "Add Task", purpose: "Add", onSubmit: addTask,));
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    final tasksDao = database.tasksDao;
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.checkListName,
      ),
      backgroundColor: Colors.grey,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: StreamBuilder<List<Task>>(
              stream: tasksDao.watchTasksCustom(widget.checkListId),
              builder: (context, AsyncSnapshot<List<Task>> snapshot) {
                final tasks = snapshot.data ?? [];
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: (Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: CheckboxListTile(
                                title: Text(
                                 task.toDo ,
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                secondary: IconButton(onPressed: (){
                                  tasksDao.deleteTask(task);
                                }, icon: Icon(Icons.delete_rounded, color: Colors.redAccent,)),
                                onChanged: (bool? value) {
                                  tasksDao.updateTask(task.copyWith(isComplete: value));
                                },
                                value: task.isComplete,
                              ),
                            ),
                          ))),
                    );
                  },
                  itemCount: tasks.length,
                );
              }
            ),
          ),
          BottomButtonBar(
            deleteFunc: deleteTasks,
            addFunc: showInputDialog,
            scrollFunc: (){},
          ),
        ],
      ),
    );
  }
}
