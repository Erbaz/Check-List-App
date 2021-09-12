import 'package:check_list_app/components/bottomButtonBar.dart';
import 'package:check_list_app/components/customAlertBox.dart';
import 'package:check_list_app/components/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:check_list_app/customClasses/task.dart';

class Tasks extends StatefulWidget {
  final List<Task> tasks;
  const Tasks({required this.tasks});
  @override
  TasksState createState() => TasksState();
}

class TasksState extends State<Tasks> {
  deleteAllTasks() {
    print(widget.tasks);
    setState(() {
      widget.tasks.clear();
    });
  }

  showInputDialog(BuildContext context){
    return showDialog(context: context, builder: (context)=>CustomAlertBox(title: "Add Task", onSubmit: (){},));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Tasks",
      ),
      backgroundColor: Colors.grey,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
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
                              widget.tasks[index]
                                  .title, //bang operator removes null allowance
                              style: TextStyle(fontSize: 20.0),
                            ),
                            onChanged: (bool? value) {
                              setState(() {
                                widget.tasks[index].completed = value ?? false;
                              });
                            },
                            value: widget.tasks[index].completed,
                          ),
                        ),
                      ))),
                );
              },
              itemCount: widget.tasks.length,
            ),
          ),
          BottomButtonBar(
            deleteFunc: deleteAllTasks,
            addFunc: showInputDialog,
          ),
        ],
      ),
    );
  }
}
