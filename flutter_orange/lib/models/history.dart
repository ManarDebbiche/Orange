class HistoryEvent {
  final String title;
  final String eventDateUtc;
  final String details;

  HistoryEvent({
    required this.title,
    required this.eventDateUtc,
    required this.details,
  });

  factory HistoryEvent.fromJson(Map<String, dynamic> json) {
    return HistoryEvent(
      title: json['title'],
      eventDateUtc: json['event_date_utc'],
      details: json['details'] ?? '',
    );
  }
}
