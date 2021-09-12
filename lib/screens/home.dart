import 'package:check_list_app/components/bottomButtonBar.dart';
import 'package:check_list_app/components/customAlertBox.dart';
import 'package:check_list_app/components/customAppbar.dart';
import 'package:check_list_app/data/moorDatabase.dart';
import 'package:check_list_app/screens/tasks.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  // List<CheckList> checkLists = [
  //   CheckList(name: "House Work", tasks: [
  //     Task(title: "Dishes", completed: false),
  //     Task(title: "Water plants", completed: false),
  //     Task(title: "Dusting", completed: true),
  //   ]),
  //   CheckList(name: "School Work"),
  //   CheckList(name: "Office Work"),
  // ];

  deleteAllCheckLists() {
    // print(checkLists);
    // setState(() {
    //   checkLists.clear();
    // });
  }

  showInputDialog(BuildContext context){
    print('show input dialog');
    showDialog(context: context, builder: (context)=>CustomAlertBox(title: "Add Checklist", onSubmit: addCheckList,));
  }

  addCheckList(BuildContext context, String checkListName, DateTime createdAt){
    print('checkListName====>${checkListName}');
    final database = Provider.of<AppDatabase>(context, listen: false);
    final CheckListsCompanion checkList = CheckListsCompanion.insert(
      checkListName: checkListName,
      createdAt: Value.ofNullable(createdAt),
    );
    database.insertCheckList(checkList);
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Check Lists",
      ),
      backgroundColor: Colors.grey,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: StreamBuilder(
              stream: database.watchAllChecklists(),
              builder: (context, AsyncSnapshot<List<CheckList>> snapshot){
                final checkLists = snapshot.data ?? [];
                return ListView.builder(
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
                                            builder: (context) => Tasks(
                                                tasks:
                                                    [])),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete_sharp, size: 25,),
                                    color: Colors.redAccent,
                                    onPressed: ()=>database.deleteCheckList(checkLists[index]),
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
          BottomButtonBar(deleteFunc: deleteAllCheckLists, addFunc: showInputDialog,),
        ],
      ),
    );
  }
}
