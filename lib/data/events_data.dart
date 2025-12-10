import 'dart:typed_data';

class Event {
  final String title;
  final String date;
  final String location;
  final String description;
  final Uint8List? imageBytes;
  final String? imageName;

  Event({
    required this.title,
    required this.date,
    required this.location,
    required this.description,
    this.imageBytes,
    this.imageName,
  });
}

List<Event> sampleEvents = [
  Event(
    title: 'Festival des Arts et Traditions',
    date: '15 janvier 2026',
    location: 'Cotonou',
    description: 'Expositions, spectacles et ateliers autour des patrimoines locaux.',
    imageBytes: null,
    imageName: 'event1.jpg',
  ),
  Event(
    title: 'Conférence: Histoire du Bénin',
    date: '28 février 2026',
    location: 'Porto-Novo',
    description: 'Conférenciers invités et table ronde sur l’histoire royale.',
    imageBytes: null,
    imageName: 'event2.jpg',
  ),
  Event(
    title: 'Atelier de percussions',
    date: '10 mars 2026',
    location: 'Parakou',
    description: 'Initiation aux rythmes traditionnels et performance collective.',
    imageBytes: null,
    imageName: 'event3.jpg',
  ),
];

