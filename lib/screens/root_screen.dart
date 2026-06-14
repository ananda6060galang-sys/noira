import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/controllers/navigation_controller.dart';
import '../app/controllers/player_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/mini_player.dart';
import 'home_screen.dart';
import 'library_screen.dart';
import 'profile_screen.dart';
import 'queue_screen.dart';
import 'search_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.find<NavigationController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        final selectedIndex = navigationController.selectedIndex.value;

        return Stack(
          children: [
            IndexedStack(
              index: selectedIndex,
              children: const [
                HomeScreen(),
                SearchScreen(),
                LibraryScreen(),
                QueueScreen(),
                ProfileScreen(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x000D0D0F),
                      Color(0xE60D0D0F),
                      AppColors.background,
                    ],
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (selectedIndex == 3) ...[
                        const _QueuePlaybackControls(),
                        const SizedBox(height: 10),
                      ],
                      const MiniPlayer(),
                      const SizedBox(height: 6),
                      const BottomNavBar(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _QueuePlaybackControls extends StatelessWidget {
  const _QueuePlaybackControls();

  @override
  Widget build(BuildContext context) {
    final playerController = Get.find<PlayerController>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF141418),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF222228)),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.shuffle, color: AppColors.textMuted, size: 21),
            const Icon(
              Icons.skip_previous,
              color: AppColors.textSecondary,
              size: 23,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: playerController.togglePlayback,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primaryContainer, Color(0xFF9060D0)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  playerController.isPlaying.value
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            const Icon(
              Icons.skip_next,
              color: AppColors.textSecondary,
              size: 23,
            ),
            const Icon(Icons.repeat, color: AppColors.textMuted, size: 21),
          ],
        ),
      ),
    );
  }
}
