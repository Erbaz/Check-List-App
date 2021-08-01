import 'package:check_list_app/components/bottomButtonBar.dart';
import 'package:check_list_app/components/customAppbar.dart';
import 'package:check_list_app/customClasses/checkList.dart';
import 'package:check_list_app/customClasses/task.dart';
import 'package:check_list_app/screens/tasks.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<CheckList> checkLists = [
    CheckList(name: "House Work", tasks: [
      Task(title: "Dishes", completed: false),
      Task(title: "Water plants", completed: false),
      Task(title: "Dusting", completed: true),
    ]),
    CheckList(name: "School Work"),
    CheckList(name: "Office Work"),
  ];

  deleteAllCheckLists() {
    print(checkLists);
    setState(() {
      checkLists.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Check Lists",
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
                          child: ListTile(
                              title: Text(
                                checkLists[index]
                                    .name!, //bang operator removes null allowance
                                style: TextStyle(fontSize: 20.0),
                              ),
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Tasks(
                                            tasks:
                                                checkLists[index].tasks ?? [])),
                                  )),
                        ),
                      ))),
                );
              },
              itemCount: checkLists.length,
            ),
          ),
          BottomButtonBar(deleteFunc: deleteAllCheckLists),
        ],
      ),
    );
  }
}
