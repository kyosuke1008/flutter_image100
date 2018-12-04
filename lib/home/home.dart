import 'package:flutter/material.dart';
import 'package:flutter_app/home/event_list.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('TEST'),
      ),
      body: EventList(),
    );
  }
}