class Dish {
  final String id;
  final String name;
  final String nameInFon;
  final String description;
  final String region;
  final List<String> ingredients;
  final List<String> steps;
  final String imageUrl;
  final String category;
  final int prepTime;
  final String difficulty;

  Dish({
    required this.id,
    required this.name,
    required this.nameInFon,
    required this.description,
    required this.region,
    required this.ingredients,
    required this.steps,
    required this.imageUrl,
    required this.category,
    required this.prepTime,
    required this.difficulty,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      name: json['name'],
      nameInFon: json['nameInFon'],
      description: json['description'],
      region: json['region'],
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
      imageUrl: json['imageUrl'],
      category: json['category'],
      prepTime: json['prepTime'],
      difficulty: json['difficulty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameInFon': nameInFon,
      'description': description,
      'region': region,
      'ingredients': ingredients,
      'steps': steps,
      'imageUrl': imageUrl,
      'category': category,
      'prepTime': prepTime,
      'difficulty': difficulty,
    };
  }
}