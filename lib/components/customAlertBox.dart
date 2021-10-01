import 'package:check_list_app/data/moorDatabase.dart';
import 'package:flutter/material.dart';


class CustomAlertBox extends StatelessWidget {
  final String title;
  final String purpose;
  final Function onSubmit;
  final CheckList? checkList;
  final Task? task;
  CustomAlertBox({ Key? key, required this.title, required this.purpose, required this.onSubmit, this.checkList, this.task }) : super(key: key);
  final TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:Text(title),
      content: TextFormField(
        controller: inputController, 
        decoration: InputDecoration(
          hintText: 'Enter Text'
        ),  
      ),
      actions: [
        TextButton(
          onPressed: (){
            if(inputController.text.isEmpty ){
              return;
            }
            else{
              if(purpose == "Add"){
                onSubmit(context, inputController.text, DateTime.now());
              }
              else if(purpose == "Edit"){
                onSubmit(context, inputController.text, checkList ?? task);
              }
              Navigator.of(context).pop();
            }
            
            
           
          }, 
          child: Text(
            purpose
          ))
      ],
    );
  }
}
// 