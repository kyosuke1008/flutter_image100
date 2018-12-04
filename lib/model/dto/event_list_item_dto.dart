/*
 * event list item dto
 * to user in event list
 */
class EventListItemDto {
  final String imageUrl;

  EventListItemDto(this.imageUrl);

  EventListItemDto.fromJson(Map<String, dynamic> json)
      : imageUrl = json['image_url'];

  Map<String, dynamic> toJson() => {
        'image_url': imageUrl,
      };
}
