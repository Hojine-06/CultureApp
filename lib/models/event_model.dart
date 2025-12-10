class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String? imageUrl;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    this.imageUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'imageUrl': imageUrl,
    };
  }

  Event copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    String? location,
    String? imageUrl,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
