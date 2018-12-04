import 'package:flutter/material.dart';
import 'package:flutter_app/home/home.dart';

const HOME_INDEX = 0;
const SEARCH_INDEX = 1;
const CHAT_INDEX = 3 ;
const PROFILE_INDEX = 4;

class Base extends StatefulWidget {

  var _selectedIndex = HOME_INDEX;

  Base(int index) {
    _selectedIndex = index;
  }

  @override
  State<StatefulWidget> createState() {
    return _BaseState(_selectedIndex);
  }
}

class _BaseState extends State<Base> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home()
  ];

  _BaseState(int selected) {
    this._currentIndex = selected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndex]
    );
  }

  void onTabTapped(int index) {
    setState(() {
      print('on tapped: $index');
      _currentIndex = index;
    });
  }
}