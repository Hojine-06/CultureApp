import 'package:flutter/material.dart';
import 'package:culture_app/screens/favorites_screen.dart';
import 'package:culture_app/screens/events_screen.dart';
import 'package:culture_app/screens/quiz_screen.dart';

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
      body: const Center(child: Text('Bienvenue dans Culture App', style: TextStyle(fontSize: 20))),
    );
  }
}
