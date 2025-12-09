import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../data/models/dish_model.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List<Dish> dishes = [];
  List<Dish> filteredDishes = [];
  String selectedCategory = 'Tous';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDishes();
  }

  Future<void> loadDishes() async {
    try {
      final String response = await rootBundle.loadString('assets/data/dishes.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        dishes = data.map((json) => Dish.fromJson(json)).toList();
        filteredDishes = dishes;
        isLoading = false;
      });
    } catch (e) {
      print('Erreur de chargement: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'Tous') {
        filteredDishes = dishes;
      } else {
        filteredDishes = dishes.where((dish) => dish.category == category).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastronomie Béninoise 🍽️'),
        backgroundColor: Colors.red[700],
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Chargement des plats...'),
                ],
              ),
            )
          : Column(
              children: [
                // Filtres par catégorie
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildCategoryChip('Tous'),
                      _buildCategoryChip('Plat principal'),
                      _buildCategoryChip('Boisson'),
                      _buildCategoryChip('Snack'),
                      _buildCategoryChip('Dessert'),
                    ],
                  ),
                ),
                
                // Liste des plats
                Expanded(
                  child: filteredDishes.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.restaurant, size: 64, color: Colors.grey[400]),
                              const SizedBox(height: 16),
                              Text(
                                'Aucun plat dans cette catégorie',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: filteredDishes.length,
                          itemBuilder: (context, index) {
                            return _buildDishCard(filteredDishes[index]);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (_) => filterByCategory(category),
        backgroundColor: Colors.white,
        selectedColor: Colors.red[700],
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        elevation: isSelected ? 4 : 1,
      ),
    );
  }

  Widget _buildDishCard(Dish dish) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          _showDishDetail(dish);
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image avec gradient coloré
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: _getGradientColors(dish.id),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.restaurant_menu,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      dish.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom du plat
                  Text(
                    dish.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  // Nom en Fon
                  Text(
                    dish.nameInFon,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red[700],
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Description
                  Text(
                    dish.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Informations
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 18, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        dish.region,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.timer, size: 18, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '${dish.prepTime} min',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(dish.difficulty),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          dish.difficulty,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Couleurs différentes pour chaque plat
  List<Color> _getGradientColors(String dishId) {
    switch (dishId) {
      case '1': // Amiwo
        return [Colors.red[300]!, Colors.orange[400]!];
      case '2': // Akassa
        return [Colors.amber[300]!, Colors.yellow[400]!];
      case '3': // Atassi
        return [Colors.green[300]!, Colors.teal[400]!];
      case '4': // Tchoukoutou
        return [Colors.brown[300]!, Colors.orange[300]!];
      case '5': // Kluiklui
        return [Colors.deepOrange[300]!, Colors.red[400]!];
      default:
        return [Colors.red[300]!, Colors.orange[400]!];
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Facile':
        return Colors.green;
      case 'Moyen':
        return Colors.orange;
      case 'Difficile':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showDishDetail(Dish dish) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              
              // Nom du plat
              Text(
                dish.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dish.nameInFon,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              
              // Badges
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildBadge(Icons.timer, '${dish.prepTime} min', Colors.blue),
                  _buildBadge(Icons.location_on, dish.region, Colors.green),
                  _buildBadge(Icons.signal_cellular_alt, dish.difficulty, _getDifficultyColor(dish.difficulty)),
                ],
              ),
              const SizedBox(height: 24),
              
              // Description
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dish.description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              
              // Ingrédients
              const Text(
                'Ingrédients',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...dish.ingredients.map((ingredient) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, size: 20, color: Colors.green[600]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        ingredient,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 24),
              
              // Étapes
              const Text(
                'Préparation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...dish.steps.asMap().entries.map((entry) {
                int idx = entry.key;
                String step = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.red[700],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${idx + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          step,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}