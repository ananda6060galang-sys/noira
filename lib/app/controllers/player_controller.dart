import 'package:get/get.dart';

import '../../models/track.dart';

class PlayerController extends GetxController {
  final currentTrack = const Track(
    title: 'Ether Drift',
    artist: 'Vesper Bloom',
    duration: '3:45',
  ).obs;
  final isPlaying = false.obs;
  final progress = 0.60.obs;

  void playTrack(Track track) {
    currentTrack.value = track;
    isPlaying.value = true;
  }

  void togglePlayback() {
    isPlaying.toggle();
  }

  void seekTo(double value) {
    progress.value = value.clamp(0, 1);
  }

  void skipNext() {
    // Audio service integration will live here later.
  }
}
