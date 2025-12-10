import 'package:go_router/go_router.dart';
import '../presentation/screens/music/music_screen.dart';
import '../presentation/screens/music/music_player_screen.dart';
import '../presentation/screens/music/video_screen.dart';
import '../data/models/music_model.dart';
import '../data/models/video_model.dart';

final routes = GoRouter(
  routes: [
    GoRoute(path: '/music', builder: (context, state) => MusicScreen()),
    GoRoute(
      path: '/music/player',
      builder: (context, state) {
        final music = state.extra as Music;
        return MusicPlayerScreen(music: music);
      },
    ),
    GoRoute(
      path: '/music/video',
      builder: (context, state) {
        final video = state.extra as Video;
        return VideoScreen(video: video);
      },
    ),
  ],
);
