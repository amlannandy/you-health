import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../services/UserInfoProvider.dart';

Widget uploadDialog({BuildContext context, Function notifyChanges}) {
  return Container(
    height: 200,
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: 50),
            Text(
              'Upload Profile Picture',
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontFamily: 'Lato',
                fontSize: 20,
              ),
            ),
            IconButton(
              icon: Icon(
                LineIcons.close,
                color: Colors.black.withOpacity(0.6),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            optionBox(context, LineIcons.camera, 'Take Picture', () {
              UserInfoProvider.takePicture(context, notifyChanges);
              Navigator.of(context).pop();
            }),
            optionBox(context, LineIcons.image, 'Upload Image', () {
              UserInfoProvider.uploadPicture(
                context,
                notifyChanges,
              );
              Navigator.of(context).pop();
            }),
          ],
        ),
      ],
    ),
  );
}

Widget optionBox(
  BuildContext context,
  IconData icon,
  String title,
  Function onPress,
) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
