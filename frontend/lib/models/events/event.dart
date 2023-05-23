class Event {
  final int id;
  final int creatorId;
  final int styleId;
  final int categoryId;
  final String title;
  final String description;
  final int participants;
  final int participantsMax;
  final String address;
  final String city;
  final String location;
  final DateTime startEvent;
  final DateTime endEvent;
  final bool isPrivate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.creatorId,
    required this.styleId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.participants,
    required this.participantsMax,
    required this.address,
    required this.city,
    required this.location,
    required this.startEvent,
    required this.endEvent,
    required this.isPrivate,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id_event'],
      creatorId: json['id_creator'],
      styleId: json['id_style'],
      categoryId: json['id_category'],
      title: json['title'],
      description: json['description'],
      participants: json['participants'],
      participantsMax: json['participants_max'],
      address: json['address'],
      city: json['city'],
      location: json['location'],
      startEvent: DateTime.parse(json['start_event']),
      endEvent: DateTime.parse(json['end_event']),
      isPrivate: json['private'] == 1,
      isActive: json['active'] == 1,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

	  Map<String, dynamic> toJson() {
    return {
      'id_event': id,
      'id_creator': creatorId,
      'id_style': styleId,
      'id_category': categoryId,
      'title': title,
      'description': description,
      'participants': participants,
      'participants_max': participantsMax,
      'address': address,
      'city': city,
      'location': location,
      'start_event': startEvent.toIso8601String(),
      'end_event': endEvent.toIso8601String(),
      'private': isPrivate ? 1 : 0,
      'active': isActive ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
