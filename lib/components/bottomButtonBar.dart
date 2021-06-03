import 'package:check_list_app/components/customElevatedButton.dart';
import 'package:flutter/material.dart';

class BottomButtonBar extends StatelessWidget {
  final Function deleteFunc;
  BottomButtonBar({required this.deleteFunc});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomElevatedButton(
                icon: Icons.delete_sharp,
                color: Color(0xFF220059),
                padding: 20.0,
                size: 30.0,
                iconColor: Colors.red.shade900,
                onPress: () => deleteFunc(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomElevatedButton(
                icon: Icons.add,
                color: Color(0xFF220059),
                padding: 20.0,
                size: 30.0,
                iconColor: Colors.white,
                onPress: () {
                  print("add");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
