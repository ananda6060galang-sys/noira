import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/controllers/player_controller.dart';
import '../app/controllers/queue_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/queue_song_tile.dart';

class QueueScreen extends StatelessWidget {
  const QueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final queueController = Get.find<QueueController>();

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 194),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _TopBar(),
            const SizedBox(height: 24),
            const Text(
              'NOW PLAYING',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            const _NowPlayingCard(),
            const SizedBox(height: 24),
            const _UpNextHeader(),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(
                () => ReorderableListView.builder(
                  padding: EdgeInsets.zero,
                  buildDefaultDragHandles: false,
                  proxyDecorator: (child, index, animation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        final t = Curves.easeOut.transform(animation.value);

                        return Transform.scale(
                          scale: 1 + (0.02 * t),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color(0xFF17171D),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFA082E6,
                                  ).withValues(alpha: 0.18 * t),
                                  blurRadius: 18,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: child,
                          ),
                        );
                      },
                      child: child,
                    );
                  },
                  itemCount: queueController.tracks.length,
                  onReorder: queueController.reorderTrack,
                  itemBuilder: (context, index) {
                    final track = queueController.tracks[index];

                    return QueueSongTile(
                      key: ValueKey('${track.title}-${track.artist}'),
                      title: track.title,
                      artist: track.artist,
                      duration: track.duration,
                      icon: track.icon,
                      dragIndex: index,
                      onRemove: () => queueController.removeTrack(track),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E24),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.textSecondary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Queue',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
        ),
        Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E24),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.settings_outlined,
            color: AppColors.textSecondary,
            size: 19,
          ),
        ),
      ],
    );
  }
}

class _NowPlayingCard extends StatelessWidget {
  const _NowPlayingCard();

  @override
  Widget build(BuildContext context) {
    final queueController = Get.find<QueueController>();
    final playerController = Get.find<PlayerController>();

    return Obx(() {
      final track = queueController.nowPlaying.value;

      return Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1C1C24), Color(0xFF18181F)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF2A2A35)),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -30,
              right: -4,
              child: Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFA082E6).withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF2A2040), Color(0xFF1A1428)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: playerController.togglePlayback,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(
                            0xFFC4A0F0,
                          ).withValues(alpha: 0.85),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        playerController.isPlaying.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: const Color(0xFFC4A0F0),
                        size: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFFE8E0FF),
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        track.artist,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _ProgressScrubber(
                        value: playerController.progress.value,
                        onChanged: (value) {
                          playerController.seekTo(value);
                          queueController.seekTo(value);
                        },
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            queueController.elapsedLabel.value,
                            style: _timeStyle,
                          ),
                          const Spacer(),
                          Text(track.duration, style: _timeStyle),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  static const _timeStyle = TextStyle(color: Color(0xFF555555), fontSize: 11);
}

class _ProgressScrubber extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const _ProgressScrubber({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const thumbRadius = 5.0;
        final trackWidth = constraints.maxWidth - (thumbRadius * 2);
        final thumbLeft = (thumbRadius + (trackWidth * value)).clamp(
          thumbRadius,
          constraints.maxWidth - thumbRadius,
        );

        void updateValue(Offset localPosition) {
          onChanged(
            ((localPosition.dx - thumbRadius) / trackWidth).clamp(0, 1),
          );
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (details) => updateValue(details.localPosition),
          onHorizontalDragUpdate: (details) =>
              updateValue(details.localPosition),
          child: SizedBox(
            height: 10,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Positioned(
                  left: thumbRadius,
                  right: thumbRadius,
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C38),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Positioned(
                  left: thumbRadius,
                  width: trackWidth * value,
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFA082E6), Color(0xFFC4A0F0)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Positioned(
                  left: thumbLeft - 5,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC4A0F0),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFB496FF).withValues(alpha: 0.2),
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _UpNextHeader extends StatelessWidget {
  const _UpNextHeader();

  @override
  Widget build(BuildContext context) {
    final queueController = Get.find<QueueController>();

    return Row(
      children: [
        const Expanded(
          child: Text(
            'Up next',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: queueController.clearQueue,
          child: const Text(
            'Clear queue',
            style: TextStyle(
              color: AppColors.primaryContainer,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
