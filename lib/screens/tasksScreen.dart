
import 'package:check_list_app/components/bottomButtonBar.dart';
import 'package:check_list_app/components/customAlertBox.dart';
import 'package:check_list_app/components/customAppbar.dart';
import 'package:check_list_app/data/moorDatabase.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';
class TasksScreen extends StatefulWidget {
  final int checkListId;
  const TasksScreen({required this.checkListId});
  @override
  TasksScreenState createState() => TasksScreenState();
}

class TasksScreenState extends State<TasksScreen> {
  deleteAllTasks() {

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
    print('CheckListId =====> ${widget.checkListId}');
    final database = Provider.of<AppDatabase>(context);
    final tasksDao = database.tasksDao;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Tasks",
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
                print('tasks=====>${snapshot.data}');
                return ListView.builder(
                  itemBuilder: (context, index) {
                    print('task ========> ${tasks[index]}');
                    debugPrint('task: ${tasks[index]}');
                    final task = tasks[index];
                    print('task:::::>${task.toDo}'); 
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
                                onChanged: (bool? value) {
                                 
                                },
                                value: false,
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
            deleteFunc: deleteAllTasks,
            addFunc: showInputDialog,
            scrollFunc: (){},
          ),
        ],
      ),
    );
  }
}
