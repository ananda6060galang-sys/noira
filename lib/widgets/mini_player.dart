import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/controllers/player_controller.dart';
import '../theme/app_colors.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final playerController = Get.find<PlayerController>();

    return Obx(() {
      final track = playerController.currentTrack.value;

      return Container(
        height: 64,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A22),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF25252E)),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 2),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF2A2040), Color(0xFF1A1428)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Image.asset(
                        'assets/images/noira_logo.png',
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/logo.png');
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            track.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            track.artist,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: playerController.skipNext,
                      child: const Icon(
                        Icons.skip_next,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: playerController.togglePlayback,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primaryContainer,
                              Color(0xFF9060D0),
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          playerController.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: playerController.progress.value,
                  child: Container(
                    height: 2,
                    color: AppColors.primaryContainer,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
