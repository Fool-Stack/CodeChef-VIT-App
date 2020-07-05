import 'package:CCApp/screens/meetings.dart';
import 'package:CCApp/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'members.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final tabs = [
    Meetings(),
    Center(
      child: Text('Projects'),
    ),
    Center(child: Text('About Us')),
    ProfilePage(),
    Members()
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.users,
                color: _currentIndex == 0 ? Color(0xFF459AFF) : Colors.grey,
              ),
              title: Text(
                'Meetings',
                style: TextStyle(
                  color: _currentIndex == 0 ? Color(0xFF459AFF) : Colors.grey,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.tasks,
                color: _currentIndex == 1 ? Color(0xFFFF6745) : Colors.grey,
              ),
              title: Text(
                'Projects',
                style: TextStyle(
                  color: _currentIndex == 1 ? Color(0xFFFF6745) : Colors.grey,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.infoCircle,
                color: _currentIndex == 2 ? Color(0xFFFF4572) : Colors.grey,
              ),
              title: Text(
                'About Us',
                style: TextStyle(
                  color: _currentIndex == 2 ? Color(0xFFFF4572) : Colors.grey,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.userAlt,
                color: _currentIndex == 3 ? Color(0xFF459AFF) : Colors.grey,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: _currentIndex == 3 ? Color(0xFF459AFF) : Colors.grey,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.users,
                color: _currentIndex == 4 ? Color(0xFFFF6745) : Colors.grey,
              ),
              title: Text(
                'Members',
                style: TextStyle(
                  color: _currentIndex == 4 ? Color(0xFFFF6745) : Colors.grey,
                ),
              ),
            ),
          ],
        ),
        body: tabs[_currentIndex]);
  }
}

Color getColor(int selector) {
  if (selector % 3 == 0) {
    return Color(0xFF459AFF);
  } else if (selector % 3 == 1) {
    return Color(0xFFFF6745);
  } else if (selector % 3 == 2) {
    return Color(0xFFFF4572);
  } else
    return null;
}

Color getSGColor(int selector) {
  if (selector % 3 == 0) {
    return Color(0xFF7BB7FF);
  } else if (selector % 3 == 1) {
    return Color(0xFFFF967E);
  } else if (selector % 3 == 2) {
    return Color(0xFFFF6C90);
  } else
    return null;
}
