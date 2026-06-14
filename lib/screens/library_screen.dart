import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/controllers/library_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/category_chip.dart';
import '../widgets/gradient_placeholder.dart';
import 'liked_songs_screen.dart';
import 'new_playlist_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final libraryController = Get.find<LibraryController>();

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 142),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(),
            const SizedBox(height: 18),
            const _Filters(),
            const SizedBox(height: 20),
            Obx(
              () => _LibraryCard(
                title: 'Liked Songs',
                subtitle: '${libraryController.likedSongsCount.value} songs',
                image: 'assets/images/liked.png',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LikedSongsScreen(),
                    ),
                  );
                },
              ),
            ),
            _LibraryCard(
              title: 'Create your own playlist',
              subtitle: 'Start a new mood',
              icon: Icons.add,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NewPlaylistScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            const _SectionTitle('Playlists'),
            const SizedBox(height: 12),
            Obx(
              () => Column(
                children: [
                  for (final item in libraryController.playlists)
                    _LibraryRow(item.title, item.subtitle, item.icon),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Text(
            'Your Library',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ),
        Icon(Icons.search, color: AppColors.textSecondary, size: 23),
        SizedBox(width: 18),
        Icon(Icons.add, color: AppColors.textSecondary, size: 25),
      ],
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters();

  @override
  Widget build(BuildContext context) {
    final libraryController = Get.find<LibraryController>();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => Row(
          children: [
            for (final filter in libraryController.filters) ...[
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => libraryController.selectFilter(filter),
                child: CategoryChip(
                  label: filter,
                  isActive: libraryController.selectedFilter.value == filter,
                ),
              ),
              if (filter != libraryController.filters.last)
                const SizedBox(width: 8),
            ],
          ],
        ),
      ),
    );
  }
}

class _LibraryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final IconData icon;
  final VoidCallback? onTap;

  const _LibraryCard({
    required this.title,
    required this.subtitle,
    this.image = '',
    this.icon = Icons.music_note_outlined,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xCC201F1F),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0x1FFFFFFF)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              SizedBox(
                width: 64,
                height: double.infinity,
                child: image.isNotEmpty
                    ? Image.asset(image, fit: BoxFit.cover)
                    : GradientPlaceholder(icon: icon, radius: 0, iconSize: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.chevron_right,
                  color: AppColors.textMuted,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _LibraryRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _LibraryRow(this.title, this.subtitle, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF251D35), Color(0xFF0F1014)],
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.more_vert, color: AppColors.textSecondary, size: 21),
        ],
      ),
    );
  }
}
