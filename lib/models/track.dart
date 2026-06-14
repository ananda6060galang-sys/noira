import 'package:flutter/material.dart';

class Track {
  final String title;
  final String artist;
  final String duration;
  final IconData icon;

  const Track({
    required this.title,
    required this.artist,
    this.duration = '',
    this.icon = Icons.graphic_eq,
  });
}
