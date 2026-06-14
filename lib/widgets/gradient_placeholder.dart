import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GradientPlaceholder extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final double radius;
  final List<Color> colors;

  const GradientPlaceholder({
    super.key,
    required this.icon,
    this.iconSize = 24,
    this.radius = 12,
    this.colors = const [AppColors.surfaceHigh, AppColors.surfaceLow],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Icon(icon, color: AppColors.accentLight, size: iconSize),
    );
  }
}
