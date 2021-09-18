import 'package:check_list_app/data/moorDatabase.dart';
import 'package:flutter/material.dart';


class CustomAlertBox extends StatelessWidget {
  final String title;
  final String purpose;
  final Function onSubmit;
  final CheckList? checkList;
  CustomAlertBox({ Key? key, required this.title, required this.purpose, required this.onSubmit, this.checkList }) : super(key: key);
  final TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:Text(title),
      content: TextField(controller: inputController,),
      actions: [
        TextButton(
          onPressed: (){
            if(purpose == "Add"){
              onSubmit(context, inputController.text, DateTime.now());
            }
            else if(purpose == "Edit"){
              onSubmit(context, inputController.text, checkList);
            }
            
            Navigator.of(context).pop();
          }, 
          child: Text(
            purpose
          ))
      ],
    );
  }
}
// 