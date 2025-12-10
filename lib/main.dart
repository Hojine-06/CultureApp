import 'package:flutter/material.dart';
import 'package:culture_app/screens/favorites_screen.dart';
import 'package:culture_app/screens/events_screen.dart';
import 'package:culture_app/screens/quiz_screen.dart';
import 'package:culture_app/data/quiz_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Culture App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/events': (context) => const EventsScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/favorites': (context) => const FavoritesScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int quizCount = sampleQuizQuestions.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Culture App')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Événements'),
              onTap: () => Navigator.pushNamed(context, '/events'),
            ),
            ListTile(
              leading: const Icon(Icons.quiz),
              title: const Text('Quiz culturel'),
              onTap: () => Navigator.pushNamed(context, '/quiz'),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favoris'),
              onTap: () => Navigator.pushNamed(context, '/favorites'),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF5F8), Color(0xFFFFF0F3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 30.0),
                    child: Column(
                      children: [
                        const Text('Bienvenue dans Culture App', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        const Text(
                          'Explorez des quiz culturels et découvrez des événements locaux.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _InfoCard(
                              title: 'Quiz',
                              subtitle: '$quizCount questions disponibles',
                              icon: Icons.quiz,
                              color: Colors.pinkAccent,
                              onPressed: () => Navigator.pushNamed(context, '/quiz'),
                            ),
                            const SizedBox(width: 12),
                            _InfoCard(
                              title: 'Événements',
                              subtitle: 'Des événements à découvrir',
                              icon: Icons.event,
                              color: Colors.pink.shade400,
                              onPressed: () => Navigator.pushNamed(context, '/events'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _InfoCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: color),
              onPressed: onPressed,
              child: const Text('Voir'),
            ),
          ],
        ),
      ),
    );
  }
}
