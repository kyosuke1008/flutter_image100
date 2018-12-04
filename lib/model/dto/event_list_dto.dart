import 'package:flutter_app/model/dto/event_list_item_dto.dart';

/*
 * event list
 */
class EventsResponseDto {
  List<EventListItemDto> eventList = new List<EventListItemDto>();

  EventsResponseDto(this.eventList);

  EventsResponseDto.fromJson(List<dynamic> response){
    if(response == null) return;
    response.forEach((value) {
      eventList.add(new EventListItemDto.fromJson(value));
    });
  }

  Map<String, List<dynamic>> toJson() =>
      {
        'eventList': eventList,
      };
}