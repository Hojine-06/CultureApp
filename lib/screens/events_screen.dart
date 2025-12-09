import 'package:flutter/material.dart';

import '../models/event_model.dart';
import 'event_detail_screen.dart';
import 'event_edit_screen.dart';

class EventsScreen extends StatefulWidget {
  static const routeName = '/events';

  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  // Sample events data. Replace with real data source later.
  List<Event> _events = [];

  List<Event> _sampleEvents() => [
        Event(
          id: 'e1',
          title: 'Concert de Musique Classique',
          description: 'Un concert exceptionnel réunissant de grands artistes.',
          date: DateTime.now().add(const Duration(days: 7)),
          location: 'Théâtre Municipal',
          imageUrl:
              'https://images.unsplash.com/photo-1506152983158-3f0dd21aa5d6?w=800',
        ),
        Event(
          id: 'e2',
          title: 'Exposition d\'art contemporain',
          description: 'Nouvelles œuvres d\'artistes locaux et internationaux.',
          date: DateTime.now().add(const Duration(days: 14)),
          location: 'Galerie Centrale',
          imageUrl:
              'https://images.unsplash.com/photo-1504198453319-5ce911bafcde?w=800',
        ),
        Event(
          id: 'e3',
          title: 'Festival de Danse',
          description: 'Trois jours de performances et d\'ateliers participatifs.',
          date: DateTime.now().add(const Duration(days: 21)),
          location: 'Parc des Expositions',
          imageUrl:
              'https://images.unsplash.com/photo-1519996525004-8f7e0f9b6d4d?w=800',
        ),
      ];

  @override
  void initState() {
    super.initState();
    _events = _sampleEvents();
  }

  String _formatDate(DateTime d) {
    final local = d.toLocal();
    return '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final events = _events;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Événements'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: events.length,
        itemBuilder: (ctx, i) {
          final e = events[i];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 4,
            child: InkWell(
              onTap: () {
                // Navigate to event detail screen
                Navigator.of(context).pushNamed(
                  EventDetailScreen.routeName,
                  arguments: e,
                );
              },
              onLongPress: () async {
                // Edit event
                final res = await Navigator.of(context).pushNamed(
                  EventEditScreen.routeName,
                  arguments: e,
                );
                if (res != null && res is Event) {
                  setState(() {
                    final idx = _events.indexWhere((ev) => ev.id == res.id);
                    if (idx >= 0) _events[idx] = res;
                  });
                }
              },
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 100,
                    color: Colors.grey.shade300,
                    child: e.imageUrl != null
                        ? Image.network(
                            e.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (ctx, err, stack) => const Icon(Icons.broken_image),
                          )
                        : const Icon(Icons.event, size: 48, color: Colors.white70),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            e.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 14),
                                  const SizedBox(width: 6),
                                  Text(_formatDate(e.date)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 14),
                                  const SizedBox(width: 6),
                                  Text(e.location),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await Navigator.of(context).pushNamed(EventEditScreen.routeName);
          if (res != null && res is Event) {
            setState(() {
              _events.add(res);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
