import 'package:flutter/material.dart';
import '../../data/models/music_model.dart';

class MusicScreen extends StatelessWidget {
  final List<Music> musics = [
    Music(
      id: '1',
      title: 'Musique 1',
      artist: 'Artiste 1',
      genre: 'Zinli',
      imageUrl: 'assets/images/music1.jpg',
      audioUrl: 'assets/audio/music1.mp3',
    ),
    Music(
      id: '2',
      title: 'Musique 2',
      artist: 'Artiste 2',
      genre: 'Tchinkounmé',
      imageUrl: 'assets/images/music2.jpg',
      audioUrl: 'assets/audio/music2.mp3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Musique Béninoise')),
      body: ListView.builder(
        itemCount: musics.length,
        itemBuilder: (context, index) {
          final music = musics[index];
          return ListTile(
            leading: Image.asset(music.imageUrl, width: 50, height: 50),
            title: Text(music.title),
            subtitle: Text(music.artist),
            onTap: () {
              // Ici tu pourras ouvrir le MusicPlayerScreen
            },
          );
        },
      ),
    );
  }
}
