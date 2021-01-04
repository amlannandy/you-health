import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/HRMScreen.dart';
import './screens/InitScreen.dart';
import './screens/HomeScreen.dart';
import './screens/LoginScreen.dart';
import './screens/AddProfileScreen.dart';

void main() => runApp(YouHealthApp());

class YouHealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        ),
      ],
      child: MaterialApp(
        title: 'YouHealth',
        theme: ThemeData(
          primaryColor: Color(0xff581b98),
          accentColor: Color(0xff581b98),
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontFamily: 'Lato',
              fontSize: 26,
            ),
            headline2: TextStyle(
              color: Colors.black,
              fontFamily: 'Lato',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            headline3: TextStyle(
              color: Color(0xffFFFFFF),
              fontFamily: 'Lato',
              fontSize: 26,
            ),
            headline4: TextStyle(
              color: Color(0xffFFFFFF),
              fontFamily: 'Lato',
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontFamily: 'Nunito',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              color: Color(0xff707070),
              fontFamily: 'Nunito',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        initialRoute: '/init',
        routes: {
          '/hrm': (ctx) => HRMScreen(),
          '/init': (ctx) => InitScreen(),
          '/home': (ctx) => HomeScreen(),
          '/login': (ctx) => LoginScreen(),
          '/add-profile': (ctx) => AddProfileScreen(),
        },
      ),
    );
  }
}
