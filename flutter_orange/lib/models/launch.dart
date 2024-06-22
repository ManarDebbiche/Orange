class Launch {
  final String missionName;
  final String launchDateUtc;
  final String? details;

  Launch({
    required this.missionName,
    required this.launchDateUtc,
    this.details,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      missionName: json['mission_name'],
      launchDateUtc: json['launch_date_utc'],
      details: json['details'],
    );
  }
}
