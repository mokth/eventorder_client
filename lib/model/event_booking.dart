class EventBooking {
  final int? eventId;
  final String? userName;
  final String? userEmail;
  final DateTime? dateBook;

  EventBooking({this.eventId, this.userName, this.userEmail, this.dateBook});

  Map<String, dynamic> toJson(EventBooking instance) => <String, dynamic>{
        'eventId': instance.eventId,
        'userName': instance.userName,
        'dateBook': instance.dateBook!.toIso8601String()
      };
}
