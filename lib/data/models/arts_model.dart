class Art {
  final String id;
  final String name;
  final String artist;
  final String description;
  final String imageUrl;
  final String category;

  Art({
    required this.id,
    required this.name,
    required this.artist,
    required this.description,
    required this.imageUrl,
    required this.category,
  });

  factory Art.fromJson(Map<String, dynamic> json) {
    return Art(
      id: json['id'],
      name: json['name'],
      artist: json['artist'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      category: json['category'],
    );
  }
}
