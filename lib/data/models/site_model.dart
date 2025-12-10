class Site {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String region;
  final String category;

  Site({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.region,
    required this.category,
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      region: json['region'],
      category: json['category'],
    );
  }
}
