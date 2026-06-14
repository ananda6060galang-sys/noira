import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LibraryItem {
  final String title;
  final String subtitle;
  final String image;
  final IconData icon;

  const LibraryItem({
    required this.title,
    required this.subtitle,
    this.image = '',
    this.icon = Icons.music_note_outlined,
  });
}

class LibraryController extends GetxController {
  final filters = const ['Playlists', 'Albums', 'Artists'];
  final selectedFilter = 'Playlists'.obs;
  final likedSongsCount = 428.obs;

  final playlists = const [
    LibraryItem(
      title: 'Midnight Echoes',
      subtitle: 'Lofi, Ambient, Focus',
      icon: Icons.nightlight_outlined,
    ),
    LibraryItem(
      title: 'Cloud Gazing',
      subtitle: 'Dream Pop, Shoegaze',
      icon: Icons.landscape_outlined,
    ),
    LibraryItem(
      title: 'Deep Fluidity',
      subtitle: 'Techno, Melodic, Dark',
      icon: Icons.graphic_eq,
    ),
  ].obs;

  void selectFilter(String filter) {
    selectedFilter.value = filter;
  }
}
