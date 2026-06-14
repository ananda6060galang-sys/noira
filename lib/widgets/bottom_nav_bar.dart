import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/controllers/navigation_controller.dart';
import '../theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      _NavItemData(Icons.home_outlined, 'Home'),
      _NavItemData(Icons.search, 'Search'),
      _NavItemData(Icons.library_music_outlined, 'Library'),
      _NavItemData(Icons.queue_music, 'Queue'),
      _NavItemData(Icons.person_outline, 'Profile'),
    ];
    final navigationController = Get.find<NavigationController>();

    return SizedBox(
      height: 48,
      child: Obx(() {
        final selectedIndex = navigationController.selectedIndex.value;

        return Row(
          children: [
            for (var i = 0; i < items.length; i++)
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => navigationController.selectTab(i),
                  child: _BottomNavItem(
                    icon: items[i].icon,
                    label: items[i].label,
                    active: selectedIndex == i,
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;

  const _NavItemData(this.icon, this.label);
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.accentLight : AppColors.textSecondary;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 19),
        const SizedBox(height: 3),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: active ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
