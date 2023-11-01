class EventDataModel {
  final String eventId;
  final String time;
  final String description;
  final String displayName;
  final String imageUrl;
  final String color;

  EventDataModel(
      this.eventId,
      this.time,
      this.description,
      this.displayName,
      this.imageUrl,
      this.color,
      );
}


class EventDataHolder {
  static List<Map<String, dynamic>> eventDataList = [];
}


