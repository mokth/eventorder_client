class Event {
  final int? eventId;
  final String? eventName;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? maxSeats;
  final int? seatBook;

  Event(
      {this.eventId,
      this.eventName,
      this.endTime,
      this.startTime,
      this.maxSeats,
      this.seatBook});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        eventId: json["eventId"],
        eventName: json["eventName"],
        startTime: (json["startTime"] == null)
            ? null
            : DateTime.parse(json["startTime"]).toLocal(),
        endTime: (json["endTime"] == null)
            ? null
            : DateTime.parse(json["endTime"]).toLocal(),
        maxSeats: (json["maxSeats"] == null) ? 0 : json["maxSeats"],
        seatBook: (json["seatBook"] == null) ? 0 : json["seatBook"]);
  }
}
