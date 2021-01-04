import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/User.dart';
import '../services/UserDatabaseService.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  bool _redirect;
  String _redirectURL;

  Future<bool> _checkAuthStatus(BuildContext ctx) async {
    try {
      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      if (currentUser == null) {
        _redirect = true;
        _redirectURL = "/login";
        return true;
      }
      UserDatabaseService databaseService = UserDatabaseService();
      User user = await databaseService.getUser(currentUser.uid);
      if (user == null) {
        _redirect = true;
        _redirectURL = "/add-profile";
        return true;
      }
      _redirectURL = "/home";
      _redirect = true;
      return true;
    } catch (err) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/home.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: Colors.white.withOpacity(0.95),
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    "YouHealth",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                FutureBuilder<bool>(
                  future: _checkAuthStatus(context),
                  builder: (BuildContext c, AsyncSnapshot<bool> snapshot) {
                    List<Widget> children = [];
                    if (snapshot.hasData && snapshot.data) {
                      new Future.delayed(Duration(milliseconds: 500), () {
                        if (_redirect)
                          Navigator.of(context)
                              .pushReplacementNamed(_redirectURL);
                      });
                      return Container();
                    } else if (snapshot.hasError) {
                      Text(
                        "Authentication Error",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                          color: Colors.red,
                        ),
                      );
                    }
                    return Column(
                      children: children,
                    );
                  },
                ),
                LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Please wait a moment...",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
