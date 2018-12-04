import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/home/event_list_item.dart';
import 'package:flutter_app/model/dto/event_list_dto.dart';
import 'package:flutter_app/model/dto/event_list_item_dto.dart';
import 'package:flutter_app/util/web_config.dart';
import 'package:http/http.dart' as http;

class EventList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    print('createState');
    return EventListState();
  }
}

class EventListState extends State<EventList> {
  var _fetchFrom = 0;
  final _fetchSize = 20;
  var _isLoading = false;
  ScrollController _scrollController;
  List<EventListItem> eventList = [];

  @override
  void initState() {
    _scrollController = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    eventList.clear();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.maxScrollExtent <=
            _scrollController.position.pixels &&
        !_isLoading) {
      _isLoading = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = size.width / 2;
    final double itemWidth = size.width / 2;

    return FutureBuilder<List<EventListItemDto>>(
      future: fetchPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          setEventListItem(snapshot.data);
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: (itemWidth / itemHeight)),
            itemBuilder: (_, int index) => eventList[index],
            itemCount: eventList.length,
            controller: _scrollController,
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text("${snapshot.error}"));
        }

        // By default, show a loading spinner
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void setEventListItem(List<EventListItemDto> events) {
    events.forEach((it) {
      var item = new EventListItem(it);
      eventList.add(item);
    });
  }

  Future<List<EventListItemDto>> fetchPost() async {
    final url = '$GET_EVENT_LIST?from=$_fetchFrom&size=$_fetchSize';
    print('fetch list: $url');
    final response = await http.get(url).whenComplete(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      var responseJson = json.decode(utf8.decode(response.bodyBytes));
      var list = EventsResponseDto.fromJson(responseJson).eventList;
      _fetchFrom += list.length;
      print('get events, size: ${list.length}');
      return list;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load event list');
    }
  }
}
