import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../models/Doctor.dart';
import '../screens/ChatScreen.dart';
import '../widgets/CustomCircleButton.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  DoctorCard(this.doctor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[350],
            blurRadius: 20.0,
            spreadRadius: 0.02,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: <Widget>[
          profileRow(context, doctor),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

Widget profileRow(BuildContext context, Doctor doctor) {
  return Container(
    child: Row(
      children: <Widget>[
        CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(doctor.imageUrl),
          backgroundColor: Colors.white,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Dr. ' + doctor.name,
              style: TextStyle(
                fontFamily: 'Varela',
                color: Colors.black.withOpacity(0.8),
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                dataPacket(doctor.field),
                SizedBox(width: 10),
                ratingContainer(context, doctor.rating),
              ],
            ),
            SizedBox(height: 8),
            buttonsRow(context, doctor),
          ],
        ),
      ],
    ),
  );
}

Widget buttonsRow(BuildContext context, Doctor doctor) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      CustomCircleButton(
        icon: LineIcons.comment,
        onPress: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => ChatScreen(doctor),
        )),
        color: Colors.red,
      ),
      CustomCircleButton(
        icon: LineIcons.phone,
        onPress: () {},
        color: Colors.green,
      ),
      CustomCircleButton(
        icon: LineIcons.video_camera,
        onPress: () {},
        color: Colors.blue,
      ),
    ],
  );
}

Widget ratingContainer(BuildContext context, double rating) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(25),
    ),
    child: Row(
      children: <Widget>[
        Icon(
          LineIcons.star,
          color: Colors.black.withOpacity(0.8),
          size: 15,
        ),
        SizedBox(width: 5),
        Text(rating.toStringAsFixed(1)),
      ],
    ),
  );
}

Widget dataPacket(String text, {Color color, Color textColor}) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 8,
    ),
    decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
            width: color == null ? 0.4 : 0,
            color: Colors.black.withOpacity(0.8))),
    child: Text(
      text,
      style: TextStyle(
        color: textColor ?? Colors.black.withOpacity(0.8),
        fontFamily: 'Varela',
        fontSize: 12,
      ),
    ),
  );
}
