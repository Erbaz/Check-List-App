import 'package:flutter/material.dart';


class CustomAlertBox extends StatelessWidget {
  final String title;
  CustomAlertBox({ Key? key, required this.title }) : super(key: key);
  TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:Text(title),
      content: TextField(controller: inputController,),
      actions: [
        TextButton(
          onPressed: (){}, 
          child: Text(
            "Add"
          ))
      ],
    );
  }
}