import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

Widget pictureContainer({
  BuildContext context,
  String imageUrl,
  Function onPress,
}) {
  return Container(
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        imageUrl == ''
            ? CircleAvatar(
                radius: 70,
                child: Icon(
                  LineIcons.user,
                  color: Colors.white,
                  size: 60,
                ),
                backgroundColor: Theme.of(context).primaryColor,
              )
            : CircleAvatar(
                radius: 70,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(imageUrl),
              ),
        GestureDetector(
          onTap: onPress,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.camera_alt,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}
