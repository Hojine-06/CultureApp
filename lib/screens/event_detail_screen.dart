import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/event_model.dart';
import 'event_edit_screen.dart';

class EventDetailScreen extends StatelessWidget {
  static const routeName = '/event-detail';

  final Event? event;

  const EventDetailScreen({super.key, this.event});

  String _formatDate(DateTime d) {
    final local = d.toLocal();
    return "${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final Event? args = event ?? ModalRoute.of(context)?.settings.arguments as Event?;
    if (args == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Détails')),
        body: const Center(child: Text('Aucun événement sélectionné.')),
      );
    }
    final ev = args;

    return Scaffold(
      appBar: AppBar(
        title: Text(ev.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ev.imageUrl != null && ev.imageUrl!.isNotEmpty)
              SizedBox(
                width: double.infinity,
                height: 200,
                child: ev.imageUrl!.startsWith('asset:')
                    ? (ev.imageUrl!.substring(6).toLowerCase().endsWith('.svg')
                        ? SvgPicture.asset(ev.imageUrl!.substring(6), fit: BoxFit.cover)
                        : Image.asset(
                            ev.imageUrl!.substring(6),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey.shade200,
                              child: const Center(child: Icon(Icons.broken_image, size: 48)),
                            ),
                          ))
                    : Image.network(
                        ev.imageUrl!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Center(child: CircularProgressIndicator()),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Center(child: Icon(Icons.broken_image, size: 48)),
                          );
                        },
                      ),
              )
            else
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey.shade200,
                child: const Center(child: Icon(Icons.event, size: 48, color: Colors.white70)),
              ),
            const SizedBox(height: 12),
            Text(
              ev.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 6),
                Text(_formatDate(ev.date)),
                const SizedBox(width: 16),
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 6),
                Expanded(child: Text(ev.location)),
              ],
            ),
            const SizedBox(height: 12),
            Text(ev.description),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                // Capture NavigatorState to avoid using BuildContext across async gap
                final nav = Navigator.of(context);
                final res = await nav.push(MaterialPageRoute(
                  builder: (_) => const EventEditScreen(),
                  settings: RouteSettings(arguments: ev),
                ));
                // If an Event was returned, pop this detail screen with the updated event
                if (res != null && res is Event) {
                  nav.pop(res);
                }
              },
              icon: const Icon(Icons.edit),
              label: const Text('Éditer cet événement'),
            ),
          ],
        ),
      ),
    );
  }
}
