import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../models/Doctor.dart';

class ChatAppBar extends StatelessWidget with PreferredSizeWidget {
  final Doctor doctor;

  ChatAppBar(this.doctor);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black.withOpacity(0.7),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.white,
      title: Container(
        child: Row(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(doctor.imageUrl),
                ),
              ),
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              doctor.name,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontFamily: 'Lato',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            LineIcons.gear,
            color: Colors.black.withOpacity(0.8),
          ),
          onPressed: () {},
        )
      ],
      bottom: PreferredSize(
        child: Container(
          color: Colors.black.withOpacity(0.8),
          height: 0.4,
        ),
        preferredSize: Size.fromHeight(4.0),
      ),
    );
  }
}
