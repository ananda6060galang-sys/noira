import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'glass_card.dart';

class SearchCategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color accent;

  const SearchCategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Positioned(
            right: -8,
            bottom: -8,
            child: Icon(icon, color: accent.withAlpha(170), size: 56),
          ),
        ],
      ),
    );
  }
}
