import 'package:flutter/material.dart';

import '../models/event_model.dart';

class EventDetailScreen extends StatelessWidget {
  static const routeName = '/event-detail';

  const EventDetailScreen({Key? key}) : super(key: key);

  String _formatDate(DateTime d) {
    final local = d.toLocal();
    return '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! Event) {
      return Scaffold(
        appBar: AppBar(title: const Text('Détails')),
        body: const Center(child: Text('Aucun événement sélectionné.')),
      );
    }

    final event = args as Event;

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Affiche l'image si l'URL est fournie, sinon un placeholder.
            if (event.imageUrl != null && event.imageUrl!.isNotEmpty)
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.network(
                  event.imageUrl!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    // Ne pas afficher le message d'erreur HTTP brut — montrer un placeholder
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
              event.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 6),
                Text(_formatDate(event.date)),
                const SizedBox(width: 16),
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 6),
                Expanded(child: Text(event.location)),
              ],
            ),
            const SizedBox(height: 12),
            Text(event.description),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Placeholder: open editor or share
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Action: Éditer / Partager')),
                );
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
