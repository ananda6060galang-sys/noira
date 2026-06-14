import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/category_chip.dart';
import '../widgets/glass_card.dart';
import '../widgets/gradient_placeholder.dart';
import '../widgets/song_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const recentSongs = [
    (
      'Nights',
      'Frank Ocean',
      Icons.circle,
      [Color(0xFF251D35), Color(0xFF0F1014)],
    ),
    (
      'After Hours',
      'The Weeknd',
      Icons.album,
      [Color(0xFF30201F), Color(0xFF141012)],
    ),
    (
      'Glimpse of Us',
      'Joji',
      Icons.blur_on,
      [Color(0xFF1B2638), Color(0xFF101116)],
    ),
    (
      'Starboy',
      'The Weeknd',
      Icons.wb_twilight,
      [Color(0xFF312449), Color(0xFF121018)],
    ),
  ];

  static const newForYouSongs = [
    (
      'Lunar Tide',
      'Sola & The Satellites',
      Icons.album,
      [Color(0xFF16151E), Color(0xFF5E2F8C)],
    ),
    (
      'The Deepest End',
      'Subaqueous',
      Icons.blur_on,
      [Color(0xFF221A46), Color(0xFF0C1224)],
    ),
    (
      'Velvet Signal',
      'Noira Radio',
      Icons.graphic_eq,
      [Color(0xFF332139), Color(0xFF141015)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return const _PageShell(
      children: [
        _Header(),
        SizedBox(height: 20),
        _FilterBar(),
        SizedBox(height: 22),
        _PlaylistGrid(),
        SizedBox(height: 26),
        _SectionHeader(title: 'Made for your mood'),
        SizedBox(height: 14),
        _MoodShelf(),
        SizedBox(height: 32),
        _SectionHeader(title: 'Recently played', showSeeAll: false),
        SizedBox(height: 14),
        _RecentSongs(),
        SizedBox(height: 22),
        _SectionHeader(title: 'New for you', showSeeAll: false),
        SizedBox(height: 14),
        _NewForYouSongs(),
      ],
    );
  }
}

class _PageShell extends StatelessWidget {
  final List<Widget> children;

  const _PageShell({required this.children});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 126),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFF2D2622),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0x334A454F)),
          ),
          alignment: Alignment.center,
          child: const Text(
            'G',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good evening',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'What do you feel tonight?',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.settings_outlined,
          color: AppColors.textSecondary,
          size: 20,
        ),
      ],
    );
  }
}

class _FilterBar extends StatefulWidget {
  const _FilterBar();

  @override
  State<_FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<_FilterBar> {
  int _selectedIndex = 0;

  static const _filters = ['All', 'Music', 'Mood', 'Playlist'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < _filters.length; i++) ...[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => _selectedIndex = i),
              child: CategoryChip(
                label: _filters[i],
                isActive: _selectedIndex == i,
              ),
            ),
            if (i != _filters.length - 1) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _PlaylistGrid extends StatelessWidget {
  const _PlaylistGrid();

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Liked Songs', 'assets/images/liked.png', Icons.favorite),
      ('bp playlist', '', Icons.person_outline),
      ('After Hours', '', Icons.album_outlined),
      ('Midnight Echoes', '', Icons.nightlight_outlined),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 48,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return GlassCard(
          padding: EdgeInsets.zero,
          radius: 10,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 38,
                    height: 38,
                    child: item.$2.isNotEmpty
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(item.$2, fit: BoxFit.cover),
                              const DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0x332A2630),
                                      Color(0x553C2263),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : GradientPlaceholder(
                            icon: item.$3,
                            iconSize: 18,
                            radius: 8,
                          ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 6, 9, 6),
                  child: Text(
                    item.$1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      height: 1.12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final bool showSeeAll;

  const _SectionHeader({required this.title, this.showSeeAll = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ),
        if (showSeeAll)
          const Text(
            'See all',
            style: TextStyle(
              color: AppColors.accentLight,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
      ],
    );
  }
}

class _MoodShelf extends StatelessWidget {
  const _MoodShelf();

  @override
  Widget build(BuildContext context) {
    const moods = [
      (
        'Midnight Echoes',
        'Lofi, Ambient, Focus',
        Icons.vertical_align_center,
        Color(0xFF252025),
        Color(0xFFD6BAFF),
      ),
      (
        'Cloud Gazing',
        'Dream Pop, Shoegaze',
        Icons.landscape_outlined,
        Color(0xFF1C2630),
        Color(0xFFAFC7D6),
      ),
      (
        'Warm Static',
        'Techno, Night Drive',
        Icons.graphic_eq,
        Color(0xFF29251C),
        Color(0xFFD6C28F),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = ((constraints.maxWidth - 18) / 2)
            .clamp(106, 142)
            .toDouble();

        return SizedBox(
          height: width + 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: moods.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final mood = moods[index];
              return SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      height: width,
                      decoration: BoxDecoration(
                        color: mood.$4,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(mood.$3, color: mood.$5, size: 26),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      mood.$1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      mood.$2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _RecentSongs extends StatelessWidget {
  const _RecentSongs();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final song in HomeScreen.recentSongs)
          SongTile(
            title: song.$1,
            artist: song.$2,
            icon: song.$3,
            colors: song.$4,
          ),
      ],
    );
  }
}

class _NewForYouSongs extends StatelessWidget {
  const _NewForYouSongs();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final song in HomeScreen.newForYouSongs)
          SongTile(
            title: song.$1,
            artist: song.$2,
            icon: song.$3,
            colors: song.$4,
          ),
      ],
    );
  }
}
