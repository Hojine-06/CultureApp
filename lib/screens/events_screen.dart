import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:culture_app/data/events_data.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late List<Event> events;

  @override
  void initState() {
    super.initState();
    events = List<Event>.from(sampleEvents);
  }

  Future<void> _showAddEventDialog() async {
    final titleCtrl = TextEditingController();
    final dateCtrl = TextEditingController();
    final locationCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    Uint8List? pickedBytes;
    String? pickedName;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text('Ajouter un événement'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Titre')),
                  TextField(controller: dateCtrl, decoration: const InputDecoration(labelText: 'Date')),
                  TextField(controller: locationCtrl, decoration: const InputDecoration(labelText: 'Lieu')),
                  TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description')),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Choisir une image'),
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                        withData: true,
                      );
                      if (result != null && result.files.isNotEmpty) {
                        pickedBytes = result.files.first.bytes;
                        pickedName = result.files.first.name;
                        setStateDialog(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  if (pickedName != null) Text('Image sélectionnée: $pickedName', style: const TextStyle(fontSize: 13)),
                  if (pickedBytes != null) const SizedBox(height: 8),
                  if (pickedBytes != null) Center(child: Image.memory(pickedBytes!, width: 120, height: 80, fit: BoxFit.cover)),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Annuler')),
              ElevatedButton(
                onPressed: () {
                  final newEvent = Event(
                    title: titleCtrl.text.isEmpty ? 'Nouvel événement' : titleCtrl.text,
                    date: dateCtrl.text.isEmpty ? 'Date à définir' : dateCtrl.text,
                    location: locationCtrl.text.isEmpty ? 'Lieu à définir' : locationCtrl.text,
                    description: descCtrl.text.isEmpty ? '' : descCtrl.text,
                    imageBytes: pickedBytes,
                    imageName: pickedName,
                  );
                  setState(() => events.insert(0, newEvent));
                  Navigator.of(context).pop();
                },
                child: const Text('Ajouter'),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Événements')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddEventDialog,
        icon: const Icon(Icons.add),
        label: const Text('Ajouter événement'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF5F8), Color(0xFFFFF0F3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: events.isEmpty
            ? const Center(
                child: Text('Aucun événement pour le moment', style: TextStyle(fontSize: 18)),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final e = events[index];
                  Widget leading;
                  if (e.imageBytes != null) {
                    leading = ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.memory(e.imageBytes!, width: 52, height: 52, fit: BoxFit.cover),
                    );
                  } else if (e.imageName != null) {
                    leading = ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        'assets/${e.imageName}',
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.event, size: 36),
                      ),
                    );
                  } else {
                    leading = CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.pinkAccent,
                              child: const Icon(Icons.event, color: Colors.white),
                    );
                  }

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          leading,
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 6),
                                Text('${e.date} • ${e.location}', style: const TextStyle(fontSize: 13, color: Colors.black54)),
                                const SizedBox(height: 8),
                                Text(e.description, style: const TextStyle(fontSize: 13)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Détails: ${e.title}')));
                            },
                            child: const Text('Détails'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
