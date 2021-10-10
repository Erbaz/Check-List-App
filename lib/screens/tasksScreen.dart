
import 'package:check_list_app/components/bottomButtonBar.dart';
import 'package:check_list_app/components/customAlertBox.dart';
import 'package:check_list_app/components/customAppbar.dart';
import 'package:check_list_app/data/moorDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';
import 'package:check_list_app/main.dart';
import 'package:timezone/standalone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';



class TasksScreen extends StatefulWidget {
  final int checkListId;
  final String checkListName;
  const TasksScreen({required this.checkListId, required this.checkListName});
  @override
  TasksScreenState createState() => TasksScreenState();
}

class TasksScreenState extends State<TasksScreen> {
  DateTime? dateSelected;
  TimeOfDay? timeSelected;
  DateTime? dateTimeSelected;

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

  editTaskName(BuildContext context, String toDo, Task task){
    final database = Provider.of<AppDatabase>(context, listen: false);
    final tasksDao = database.tasksDao;
    tasksDao.updateTask(task.copyWith(toDo: toDo));
  }

  addReminder(BuildContext context, DateTime reminder, Task task){
    final database = Provider.of<AppDatabase>(context, listen: false);
    final tasksDao = database.tasksDao;
    tasksDao.updateTask(task.copyWith(reminder: reminder));
  }

  showInputDialog(BuildContext context){
    return showDialog(context: context, builder: (context)=>CustomAlertBox(title: "Add Task", purpose: "Add", onSubmit: addTask,));
  }

  showOptionsDialog(BuildContext context, Task task){
     final database = Provider.of<AppDatabase>(context, listen: false);
      final tasksDao = database.tasksDao;
    return showDialog(
      context: context, 
      builder: (context)=>AlertDialog(
        title: Text('Options'),
        content: Row(
          children: [
            IconButton(onPressed: ()=>{
              tasksDao.deleteTask(task),
              Navigator.of(context).pop()
            }, 
            icon: Icon(Icons.delete, color: Colors.redAccent, size: 40.0,)),
            SizedBox(width:10),
            IconButton(onPressed: ()=>{
              Navigator.of(context).pop(),
              showDialog(
                context: context, 
                builder: (context)=>CustomAlertBox(title: "Edit Task", purpose: "Edit", onSubmit: editTaskName, task: task)
              ),
              
            }, 
            icon: Icon(Icons.edit, color:Colors.grey, size: 40.0)),
             SizedBox(width:10),
            IconButton(onPressed: ()=>{
              dateTimePicker(context, task)
            }, 
              icon: Icon(Icons.notification_add, color: Colors.yellowAccent[700], size:40.0)
            )
          ],
        )
      )
    );

  }

  void scheduleAlarm (DateTime reminderDateTime, String toDo, int id) async{
    var timezone = await FlutterNativeTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    TZDateTime scheduleDateTime = tz.TZDateTime.from(reminderDateTime, tz.getLocation(timezone));

     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id, 
        'Reminder', 
        toDo,
        scheduleDateTime, 
        platformChannelSpecifics, 
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future dateTimePicker(BuildContext context, Task task) async {
    final initDate = new DateTime.now();
    final newDate = await showDatePicker(
      context: context, 
      initialDate: initDate, 
      firstDate: DateTime(initDate.year, initDate.month, initDate.day ), 
      lastDate: DateTime(DateTime.now().year + 1)
    );

    if(newDate == null){
      return;
    }
    else{
      final initialTime = TimeOfDay.now();
      final newTime = await showTimePicker(
        context: context, 
        initialTime: timeSelected ?? initialTime
      );
      if( newTime == null){
        return;
      }
      else{
        DateTime dateTimeSelected =  new DateTime(newDate.year, newDate.month, newDate.day, newTime.hour, newTime.minute, 0);
        if(dateTimeSelected.isAfter(DateTime.now())){
          addReminder(context, dateTimeSelected, task);
          scheduleAlarm(dateTimeSelected, task.toDo, task.id);
        }
      
      }
    
    }
  }



  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    final tasksDao = database.tasksDao;
    print("**********RENDER**************");
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.checkListName,
      ),
      backgroundColor: Colors.indigo[300],
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
                          color: task.reminder != null? task.reminder!.isBefore(DateTime.now())? Colors.white: Colors.deepPurple[800] : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: GestureDetector(
                                onLongPress: (){
                                  showOptionsDialog(context, task);
                                },
                                child: CheckboxListTile(
                                  contentPadding: EdgeInsets.all(0.0),
                                  title: Text(
                                   task.toDo ,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: task.reminder != null && task.reminder!.isAfter(DateTime.now())? Colors.white : Colors.black
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top:8.0),
                                    child: Text(
                                      (task.reminder != null)? task.reminder!.isBefore(DateTime.now())?'(long press for options)':'reminder: ${new DateFormat('dd/MM/yyyy hh:mm a').format(task.reminder!)}'+'\n(long press for options)' : '(long press for options)',
                                      style: TextStyle(
                                        color: task.reminder != null && task.reminder!.isAfter(DateTime.now())? Colors.white : Colors.black
                                      ),
                                    ),
                                  ),
                                  
                                  onChanged: (bool? value) {
                                    tasksDao.updateTask(task.copyWith(isComplete: value));
                                  },
                                  value: task.isComplete,
                                ),
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
