import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const CategoryChip({super.key, required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : const Color(0xFF242328),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.outline,
        ),
      ),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        style: TextStyle(
          color: isActive ? AppColors.onPrimary : AppColors.textPrimary,
          fontSize: 12,
          fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
        ),
        child: Text(label),
      ),
    );
  }
}
