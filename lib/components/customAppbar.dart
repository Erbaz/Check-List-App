import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    this.title,
  });
  final title;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 12.0,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      backgroundColor: Color(0xFF220059),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }
}
