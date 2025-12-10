import 'package:flutter/material.dart';
import 'screens/events_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/event_edit_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Culture App',
      routes: {
        EventsScreen.routeName: (c) => const EventsScreen(),
        '/quiz': (c) => const QuizScreen(),
        EventDetailScreen.routeName: (c) => const EventDetailScreen(),
        EventEditScreen.routeName: (c) => const EventEditScreen(),
      },
      home: const HomeScreen(),
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
          ],
        ),
      ),
      body: const Center(child: Text('Bienvenue dans Culture App', style: TextStyle(fontSize: 20))),
    );
  }
}
