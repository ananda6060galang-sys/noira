import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PlaylistGridCard extends StatelessWidget {
  final String title;
  final String image;
  final int index;

  const PlaylistGridCard({
    super.key,
    required this.title,
    required this.image,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF303037)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: AspectRatio(
                aspectRatio: 1,
                child: image.isNotEmpty
                    ? Image.asset(image, fit: BoxFit.cover)
                    : _AlbumPlaceholder(index: index),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 8, 12, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    height: 1.18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlbumPlaceholder extends StatelessWidget {
  final int index;

  const _AlbumPlaceholder({required this.index});

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.auto_awesome,
      Icons.nights_stay,
      Icons.equalizer,
      Icons.dark_mode,
      Icons.blur_on,
      Icons.headphones,
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.accentSoft, Color(0xFF3A2A50)],
        ),
      ),
      child: Icon(
        icons[index % icons.length],
        color: AppColors.accent,
        size: 23,
      ),
    );
  }
}
