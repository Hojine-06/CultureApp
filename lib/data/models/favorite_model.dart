import 'dart:convert';

class Favorite {
  final String id;
  final String type; // 'event' or 'quiz'
  final String title;
  final Map<String, dynamic>? metadata;

  Favorite({
    required this.id,
    required this.type,
    required this.title,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'title': title,
        'metadata': metadata,
      };

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json['id'] as String,
        type: json['type'] as String,
        title: json['title'] as String,
        metadata: json['metadata'] != null
            ? Map<String, dynamic>.from(json['metadata'] as Map)
            : null,
      );

  String encode() => jsonEncode(toJson());

  static Favorite decode(String s) => Favorite.fromJson(jsonDecode(s));
}
