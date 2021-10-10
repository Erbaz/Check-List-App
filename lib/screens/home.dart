import 'package:check_list_app/components/bottomButtonBar.dart';
import 'package:check_list_app/components/customAlertBox.dart';
import 'package:check_list_app/components/customAppbar.dart';
import 'package:check_list_app/data/moorDatabase.dart';
import 'package:check_list_app/screens/tasksScreen.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  
  final scrollController = ScrollController();
  bool scrolledToBottom = false;

  showInputDialog(BuildContext context){
    print('show input dialog');
    showDialog(context: context, builder: (context)=>CustomAlertBox(title: "Add Checklist", purpose:'Add', onSubmit: addCheckList,));
  }

  addCheckList(BuildContext context, String checkListName, DateTime createdAt){
    print('checkListName====>$checkListName');
    final database = Provider.of<AppDatabase>(context, listen: false);
    final checkListsDao = database.checkListsDao;
    final CheckListsCompanion checkList = CheckListsCompanion.insert(
      checkListName: checkListName,
      createdAt: Value.ofNullable(createdAt),
    );
    checkListsDao.insertCheckList(checkList);
  }

  editCheckList(BuildContext context,String checkListName, CheckList checkList){
    print('checkListName===> $checkListName');
    final database = Provider.of<AppDatabase>(context, listen: false);
    final checkListsDao = database.checkListsDao;
    checkListsDao.updateCheckList(checkList.copyWith(checkListName: checkListName));
  }

  deleteAllCheckLists(BuildContext context){
    final database = Provider.of<AppDatabase>(context, listen: false);
    final checkListsDao = database.checkListsDao;
    final tasksDao = database.tasksDao;
    showDialog(context: context, builder: (context)=>
      AlertDialog(  
        title: Text("ATTENTION!"),  
        content: Text("Are you sure you want to delete all check lists?"),  
        actions: [  
          TextButton(
            onPressed: ()=>{
              checkListsDao.deleteAllCheckLists(),
              tasksDao.deleteAllTasks(),
              Navigator.of(context).pop()
            }, 
          child: Text("Ok")),  
        ],  
      )
    );  
  }

  scrollFunc(){
    if(scrolledToBottom == false){
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
    else{
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );

    }
    setState(() {
        scrolledToBottom = !scrolledToBottom;
    });
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    final checkListsDao = database.checkListsDao;
    final tasksDao = database.tasksDao;
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Check Lists",
      ),
      backgroundColor: Colors.indigo[300],
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: StreamBuilder(
              stream: checkListsDao.watchAllChecklists(),
              builder: (context, AsyncSnapshot<List<CheckList>> snapshot){
                final checkLists = snapshot.data ?? [];
                return ListView.builder(
                  controller: scrollController,
                  itemBuilder: (context, index) =>
                    index>=checkLists.length? 
                    SizedBox(height: 100,) 
                    :Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: (Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              child: ListTile(
                                  title: Text(
                                    checkLists[index]
                                        .checkListName, //bang operator removes null allowance
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  subtitle: Text('Created On: ${(DateFormat('dd-MM-yyyy').format(checkLists[index].createdAt!)).toString()}'),
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TasksScreen( checkListId: checkLists[index].id, checkListName: checkLists[index].checkListName),
                                        ),
                                  ),
                                  trailing: Wrap(
                                   
                                    children: [
                                      IconButton(
                                        onPressed:()=>showDialog(
                                          context: context, 
                                          builder: (context)=> CustomAlertBox(title: "Edit Checklist Name", purpose:'Edit', onSubmit: editCheckList, checkList:checkLists[index]),
                                        ), 
                                        icon: Icon(Icons.edit, size: 25,),
                                        color: Colors.blueGrey,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete_sharp, size: 25,),
                                        color: Colors.redAccent,
                                        onPressed: ()=> {
                                          checkListsDao.deleteCheckList(checkLists[index]),
                                          tasksDao.deleteTasks(checkLists[index].id)
                                        },
                                      ),
                                    ],
                                  ),
                              ),
                            ),
                          ))),
                  ),
                  
                  itemCount: checkLists.length + 1,
                );
              }
            )
          ),
          StreamBuilder(
            stream: checkListsDao.watchAllChecklists(),
            builder: (context, AsyncSnapshot<List<CheckList>> snapshot){
              final checkLists = snapshot.data ?? [];
              return BottomButtonBar(deleteFunc: checkLists.length>0?deleteAllCheckLists: (){} , addFunc: showInputDialog, scrollFunc: scrollFunc, scrolledToBottom: scrolledToBottom);
            }
          ),
          
        ],
      ),
    );
  }
}
