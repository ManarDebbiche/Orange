class Mission {
  final String missionName;
  final List<String>? manufacturers;
  final List<String>? payloadIds;
  final String? wikipedia;
  final String? description;

  Mission({
    required this.missionName,
    this.manufacturers,
    this.payloadIds,
    this.wikipedia,
    this.description,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      missionName: json['mission_name'] ?? '',
      manufacturers: (json['manufacturers'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      payloadIds: (json['payload_ids'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      wikipedia: json['wikipedia'] as String?,
      description: json['description'] as String?,
    );
  }
}
