import 'package:flutter/material.dart';
import 'presentation/screens/food/food_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Culture Béninoise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF009E60), // Vert béninois
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF009E60),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Culture Béninoise 🇧🇯'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF009E60).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // En-tête de bienvenue
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF009E60),
                      Color(0xFFE8112D),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      '🇧🇯',
                      style: TextStyle(fontSize: 48),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Bienvenue',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Découvrez la richesse culturelle du Bénin',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Grille des modules
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _buildModuleCard(
                  context,
                  icon: Icons.location_city,
                  title: 'Patrimoine',
                  color: Colors.orange,
                  onTap: () {
                    _showComingSoon(context, 'Patrimoine');
                  },
                ),
                _buildModuleCard(
                  context,
                  icon: Icons.palette,
                  title: 'Arts',
                  color: Colors.purple,
                  onTap: () {
                    _showComingSoon(context, 'Arts');
                  },
                ),
                _buildModuleCard(
                  context,
                  icon: Icons.music_note,
                  title: 'Musique',
                  color: Colors.blue,
                  onTap: () {
                    _showComingSoon(context, 'Musique');
                  },
                ),
              _buildModuleCard(
  context,
  icon: Icons.restaurant,
  title: 'Gastronomie',
  color: Colors.red,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FoodScreen()),
    );
  },
),
                _buildModuleCard(
                  context,
                  icon: Icons.language,
                  title: 'Langues',
                  color: Colors.teal,
                  onTap: () {
                    _showComingSoon(context, 'Langues');
                  },
                ),
                _buildModuleCard(
                  context,
                  icon: Icons.celebration,
                  title: 'Événements',
                  color: Colors.pink,
                  onTap: () {
                    _showComingSoon(context, 'Événements');
                  },
                ),
                _buildModuleCard(
                  context,
                  icon: Icons.photo_library,
                  title: 'Galerie',
                  color: Colors.indigo,
                  onTap: () {
                    _showComingSoon(context, 'Galerie');
                  },
                ),
                _buildModuleCard(
                  context,
                  icon: Icons.quiz,
                  title: 'Quiz',
                  color: Colors.amber,
                  onTap: () {
                    _showComingSoon(context, 'Quiz');
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Pied de page
            Center(
              child: Text(
                'Application développée par l\'équipe CultureApp 🚀',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.8),
                color,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String module) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Module $module bientôt disponible !'),
        backgroundColor: const Color(0xFF009E60),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}