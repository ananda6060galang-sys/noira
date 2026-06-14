import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SongTile extends StatelessWidget {
  final String title;
  final String artist;
  final IconData icon;
  final List<Color> colors;

  const SongTile({
    super.key,
    required this.title,
    required this.artist,
    required this.icon,
    this.colors = const [Color(0xFF251D35), Color(0xFF0F1014)],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -12,
                  right: -10,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accentLight.withValues(alpha: 0.18),
                    ),
                  ),
                ),
                Center(
                  child: Icon(icon, color: AppColors.accentLight, size: 20),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          const Icon(Icons.more_vert, color: AppColors.textPrimary, size: 21),
        ],
      ),
    );
  }
}
