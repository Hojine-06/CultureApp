import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../data/models/music_model.dart';

class MusicPlayerScreen extends StatefulWidget {
  final Music music;
  MusicPlayerScreen({required this.music});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void togglePlay() {
    if (isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(UrlSource(widget.music.audioUrl));
    }
    setState(() => isPlaying = !isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.music.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(widget.music.imageUrl, width: 200, height: 200),
          Text(widget.music.artist),
          IconButton(
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            iconSize: 64,
            onPressed: togglePlay,
          ),
        ],
      ),
    );
  }
}
