import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/song_tile.dart';

class LikedSongsScreen extends StatefulWidget {
  const LikedSongsScreen({super.key});

  @override
  State<LikedSongsScreen> createState() => _LikedSongsScreenState();
}

class _LikedSongsScreenState extends State<LikedSongsScreen> {
  static const _collapseOffset = 170.0;

  bool _showCollapsedHeader = false;

  static const _songs = [
    ('Nights', 'Frank Ocean', Icons.circle),
    ('After Hours', 'The Weeknd', Icons.album),
    ('Glimpse of Us', 'Joji', Icons.blur_on),
    ('Starboy', 'The Weeknd', Icons.wb_twilight),
    ('Solace', 'Lorn', Icons.nightlight_outlined),
    ('Ether Drift', 'Vesper Bloom', Icons.graphic_eq),
    ('Soft Static', 'Noira Radio', Icons.waves_outlined),
    ('Soft Static', 'Noira Radio', Icons.waves_outlined),
    ('Soft Static', 'Noira Radio', Icons.waves_outlined),
    ('Soft Static', 'Noira Radio', Icons.waves_outlined),
    ('Soft Static', 'Noira Radio', Icons.waves_outlined),
    ('Soft Static', 'Noira Radio', Icons.waves_outlined),
    ('Soft Static', 'Noira Radio', Icons.waves_outlined),
    ('Soft Static', 'Noira Radio', Icons.waves_outlined),
  ];

  bool _handleScroll(ScrollNotification notification) {
    if (notification.depth != 0) return false;

    final shouldShow = notification.metrics.pixels > _collapseOffset;
    if (shouldShow != _showCollapsedHeader) {
      setState(() => _showCollapsedHeader = shouldShow);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: NotificationListener<ScrollNotification>(
              onNotification: _handleScroll,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF3A2A4D), AppColors.background],
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TopBar(onBack: () => Navigator.of(context).pop()),
                          const SizedBox(height: 14),
                          const _SearchSortRow(),
                          const SizedBox(height: 85),
                          const _HeaderTitle(),
                          const SizedBox(height: 12),
                          const _ControlsRow(),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TagRow(),
                          SizedBox(height: 12),
                          _AddRow(),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final song = _songs[index];
                        return SongTile(
                          title: song.$1,
                          artist: song.$2,
                          icon: song.$3,
                        );
                      }, childCount: _songs.length),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _CollapsedHeader(
              visible: _showCollapsedHeader,
              onBack: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CollapsedHeader extends StatelessWidget {
  final bool visible;
  final VoidCallback onBack;

  const _CollapsedHeader({required this.visible, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: Container(
          width: double.infinity,
          height: topPadding + 58,
          padding: EdgeInsets.only(top: topPadding),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [AppColors.background, Color(0xFF3A2A4D)],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 16,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onBack,
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.textPrimary,
                      size: 26,
                    ),
                  ),
                ),
              ),
              const Text(
                'Liked Songs',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;

  const _TopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onBack,
          child: const SizedBox(
            width: 34,
            height: 34,
            child: Icon(
              Icons.arrow_back,
              color: AppColors.textPrimary,
              size: 24,
            ),
          ),
        ),
        const Spacer(),
        const SizedBox(
          width: 44,
          height: 34,
          child: Icon(
            Icons.more_horiz,
            color: AppColors.textSecondary,
            size: 24,
          ),
        ),
      ],
    );
  }
}

class _SearchSortRow extends StatelessWidget {
  const _SearchSortRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 11),
            decoration: BoxDecoration(
              color: AppColors.surfaceLow,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0x334A454F)),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: AppColors.textSecondary, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Find in Liked Songs',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceLow,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0x334A454F)),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Sort',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderTitle extends StatelessWidget {
  const _HeaderTitle();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Liked Songs',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 34,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
        SizedBox(height: 14),
        Text(
          '428 songs',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ControlsRow extends StatelessWidget {
  const _ControlsRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: const [
          Icon(
            Icons.download_for_offline_outlined,
            color: AppColors.textSecondary,
            size: 24,
          ),
          SizedBox(width: 16),
          Icon(Icons.shuffle, color: AppColors.textSecondary, size: 24),
          Spacer(),
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primaryContainer,
            child: Icon(Icons.play_arrow, color: AppColors.onPrimary, size: 31),
          ),
        ],
      ),
    );
  }
}

class _TagRow extends StatelessWidget {
  const _TagRow();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          _Tag(label: 'Pop', active: true),
          SizedBox(width: 8),
          _Tag(label: 'R&B'),
          SizedBox(width: 8),
          _Tag(label: 'Make this a playlist', icon: Icons.music_note),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final bool active;
  final IconData? icon;

  const _Tag({required this.label, this.active = false, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 13),
      decoration: BoxDecoration(
        color: active ? AppColors.primaryContainer : AppColors.surfaceLow,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: active ? AppColors.primaryContainer : AppColors.outline,
        ),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: active ? AppColors.onPrimary : AppColors.textPrimary,
              size: 18,
            ),
            const SizedBox(width: 7),
          ],
          Text(
            label,
            style: TextStyle(
              color: active ? AppColors.onPrimary : AppColors.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddRow extends StatelessWidget {
  const _AddRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.cardHigh,
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Icon(
            Icons.add,
            color: AppColors.textSecondary,
            size: 26,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Add to this playlist',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
