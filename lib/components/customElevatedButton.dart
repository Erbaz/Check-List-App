import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {required this.icon,
      required this.color,
      required this.padding,
      required this.size,
      required this.iconColor,
      required this.onPress});
  final double size;
  final IconData icon;
  final double padding;
  final Color color;
  final Color iconColor;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Icon(
        icon,
        size: size,
        color: iconColor,
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(padding),
        primary: color,
        elevation: 10,
      ),
    );
  }
}
