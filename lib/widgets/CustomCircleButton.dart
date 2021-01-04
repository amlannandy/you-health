import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
  final Function onPress;
  final IconData icon;
  final Color color;

  CustomCircleButton({this.icon, this.onPress, this.color});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[350],
            blurRadius: 20.0,
            spreadRadius: 0.02,
          ),
        ],
      ),
      height: height * 0.055,
      width: height * 0.055,
      child: IconButton(
        iconSize: height * 0.02,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(5),
        color: Theme.of(context).primaryColor,
        onPressed: onPress,
      ),
    );
  }
}
