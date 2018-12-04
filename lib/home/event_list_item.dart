import 'package:flutter/material.dart';
import 'package:flutter_app/model/dto/event_list_item_dto.dart';

class EventListItem extends StatelessWidget {
  final EventListItemDto eventListItem;
  BuildContext context;

  EventListItem(this.eventListItem);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return getEventCard();
  }

  Widget getEventCard() {
    return InkWell(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // event image
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: new FadeInImage(
                  placeholder: new AssetImage('images/event_default_image.png'),
                  image: new NetworkImage(eventListItem.imageUrl),
                )),
          ],
        ),
      ),
    );
  }
}
