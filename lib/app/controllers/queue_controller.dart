import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/track.dart';

class QueueController extends GetxController {
  final nowPlaying = const Track(
    title: 'Ether Drift',
    artist: 'Vesper Bloom',
    duration: '3:45',
    icon: Icons.pause_circle_outline,
  ).obs;
  final elapsedLabel = '2:14'.obs;
  final progress = 0.60.obs;

  final tracks = <Track>[
    const Track(
      title: 'Midnight FM',
      artist: 'Lunar Sequence',
      duration: '4:12',
      icon: Icons.blur_on,
    ),
    const Track(
      title: 'Static Waves',
      artist: 'Echo Unit',
      duration: '3:05',
      icon: Icons.device_hub,
    ),
    const Track(
      title: 'Cerulean Night',
      artist: 'Velvet Glitch',
      duration: '5:20',
      icon: Icons.location_city_outlined,
    ),
    const Track(
      title: 'Pulse of Dust',
      artist: 'Soma',
      duration: '2:58',
      icon: Icons.landscape_outlined,
    ),
    const Track(
      title: 'Solace',
      artist: 'Lorn',
      duration: '4:44',
      icon: Icons.nightlight_outlined,
    ),
    const Track(
      title: 'Low Tide',
      artist: 'Nova Blur',
      duration: '3:38',
      icon: Icons.waves_outlined,
    ),
  ].obs;

  void removeTrack(Track track) {
    tracks.remove(track);
  }

  void clearQueue() {
    tracks.clear();
  }

  void reorderTrack(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final track = tracks.removeAt(oldIndex);
    tracks.insert(newIndex, track);
  }

  void seekTo(double value) {
    progress.value = value.clamp(0, 1);
  }
}
