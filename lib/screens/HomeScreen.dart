import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import './MenuScreen.dart';
import './TestsScreen.dart';
import './ChatbotScreen.dart';
import './AllDoctorsScreen.dart';
import '../widgets/HomeAppBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _pageController = PageController(initialPage: 0);

  Map<String, Widget> _pages = {
    "Doctors": AllDoctorsScreen(),
    "Chatbot": ChatbotScreen(),
    "Tests": TestsScreen(),
    "Menu": MenuScreen(),
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: homeAppBar(context, user == null ? '' : user.uid),
      body: PageView(
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        controller: _pageController,
        children: _pages.values.toList(),
      ),
      bottomNavigationBar: googleNavBar(context),
    );
  }

  Widget googleNavBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            gap: 5,
            activeColor: Theme.of(context).primaryColor,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: Duration(milliseconds: 800),
            tabBackgroundColor: Colors.white,
            tabs: [
              GButton(
                icon: LineIcons.users,
                text: 'Doctors',
                iconColor: Colors.white,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
              GButton(
                icon: LineIcons.comment_o,
                text: 'Chatbot',
                iconColor: Colors.white,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
              GButton(
                icon: LineIcons.hospital_o,
                text: 'Tests',
                iconColor: Colors.white,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
              GButton(
                icon: LineIcons.bars,
                text: 'Menu',
                iconColor: Colors.white,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              );
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
