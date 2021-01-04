import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';
import '../widgets/PrimaryButton.dart';
import '../services/UserDatabaseService.dart';
import '../services/FirebaseAuthenticationService.dart';

class MenuScreen extends StatelessWidget {
  final _auth = FirebaseAuthenticationService();
  final _userDatabaseService = UserDatabaseService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return user == null
        ? Center(child: CircularProgressIndicator())
        : StreamBuilder<User>(
            stream: _userDatabaseService.streamUser(user.uid),
            builder: (context, snapshot) {
              final user = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  SizedBox(height: 20),
                  userInfo(context, user),
                  SizedBox(height: 20),
                  PrimaryButton(
                    text: 'LOG OUT',
                    onPress: () => _auth.logOut(context),
                    color: Colors.red,
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Text('Created by -'),
                      Text('Amlan Kumar Nandy'),
                      Text('Email - amlannandy5@gmail.com'),
                      Text('Phone - 7205835571'),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              );
            });
  }

  Widget userInfo(BuildContext context, User user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(user.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          user.name,
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 5),
        Text(
          user.email,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
            fontFamily: 'Lato',
          ),
        ),
      ],
    );
  }
}
