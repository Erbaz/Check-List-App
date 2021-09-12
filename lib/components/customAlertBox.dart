import 'package:flutter/material.dart';


class CustomAlertBox extends StatelessWidget {
  final String title;
  final Function onSubmit;
  CustomAlertBox({ Key? key, required this.title, required this.onSubmit }) : super(key: key);
  final TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:Text(title),
      content: TextField(controller: inputController,),
      actions: [
        TextButton(
          onPressed: (){
            onSubmit(context, inputController.text, DateTime.now());
            Navigator.of(context).pop();
          }, 
          child: Text(
            "Add"
          ))
      ],
    );
  }
}
// 