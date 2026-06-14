import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class QueueSongTile extends StatelessWidget {
  final String title;
  final String artist;
  final String duration;
  final IconData icon;
  final int? dragIndex;
  final VoidCallback? onRemove;

  const QueueSongTile({
    super.key,
    required this.title,
    required this.artist,
    required this.duration,
    this.icon = Icons.graphic_eq,
    this.dragIndex,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final tile = Padding(
      padding: const EdgeInsets.only(right: 4, bottom: 8),
      child: Container(
        constraints: const BoxConstraints(minHeight: 72),
        padding: const EdgeInsets.fromLTRB(2, 8, 10, 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            const SizedBox(
              width: 24,
              height: 56,
              child: Center(child: _DragBars()),
            ),
            const SizedBox(width: 10),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF201B2E), Color(0xFF101116)],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -12,
                    right: -10,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accentLight.withValues(alpha: 0.16),
                      ),
                    ),
                  ),
                  Center(
                    child: Icon(icon, color: AppColors.accentLight, size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              duration,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onRemove,
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFF222228),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: AppColors.textMuted,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (dragIndex == null) return tile;

    return ReorderableDelayedDragStartListener(index: dragIndex!, child: tile);
  }
}

class _DragBars extends StatelessWidget {
  const _DragBars();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 3; i++) ...[
          Container(
            width: 14,
            height: 2,
            decoration: BoxDecoration(
              color: const Color(0xFF383840),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          if (i != 2) const SizedBox(height: 3),
        ],
      ],
    );
  }
}
