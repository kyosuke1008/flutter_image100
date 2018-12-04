import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/base.dart';

/*
 * the first activity
 */
void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          primaryColor: Color(0xFFFFFFFF),
          accentColor: Color(0xFFFFFFFF)
      ),
      home: Base(HOME_INDEX),
    );
  }
}