import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 330,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF3A2A4D),
                      Color(0xFF2A2040),
                      Color(0xFF17121F),
                      AppColors.background,
                    ],
                    stops: [0.0, 0.34, 0.72, 1.0],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopBar(
                    onSettings: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const _ProfileHero(),
                  const SizedBox(height: 58),
                  const _StatsRow(),
                  const SizedBox(height: 28),
                  const Text(
                    'Playlists',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const _PlaylistRow(
                    title: 'Shazam',
                    subtitle: '7 likes',
                    colors: [Color(0xFF262631), Color(0xFF3C3C45)],
                  ),
                  const _PlaylistRow(
                    title: 'Roadtrip',
                    subtitle: '4 likes',
                    colors: [Color(0xFF28211F), Color(0xFF4A3432)],
                  ),
                  const _PlaylistRow(
                    title: 'Study',
                    subtitle: '5 likes',
                    colors: [Color(0xFF202831), Color(0xFF363246)],
                  ),
                  const SizedBox(height: 8),
                  const _SeeAllRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onSettings;

  const _TopBar({required this.onSettings});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.chevron_left, color: Color(0xFFB8C2C6), size: 24),
        const Spacer(),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onSettings,
          child: const SizedBox(
            width: 42,
            height: 34,
            child: Icon(Icons.more_horiz, color: Color(0xFFECECEC), size: 25),
          ),
        ),
      ],
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2D2622)
            ),
            child: const Icon(
              Icons.person,
              color: AppColors.textPrimary,
              size: 64,
            ),
          ),
          const SizedBox(height: 38),
          Container(
            height: 30,
            width: 105,
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A3D),
              borderRadius: BorderRadius.circular(99),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Edit Profile',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _ProfileStat(value: '23', label: 'PLAYLISTS'),
        _ProfileStat(value: '58', label: 'FOLLOWERS'),
        _ProfileStat(value: '43', label: 'FOLLOWING'),
      ],
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
      ],
    );
  }
}

class _PlaylistRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Color> colors;

  const _PlaylistRow({
    required this.title,
    required this.subtitle,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          _PlaylistMosaic(colors: colors),
          const SizedBox(width: 14),
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 25),
        ],
      ),
    );
  }
}

class _PlaylistMosaic extends StatelessWidget {
  final List<Color> colors;

  const _PlaylistMosaic({required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: GridView.count(
          crossAxisCount: 2,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            _CoverTile(color: colors.first, icon: Icons.graphic_eq),
            const _CoverTile(color: Color(0xFF15151A), icon: Icons.album),
            _CoverTile(color: colors.last, icon: Icons.nightlight_outlined),
            const _CoverTile(color: Color(0xFF24242B), icon: Icons.waves),
          ],
        ),
      ),
    );
  }
}

class _CoverTile extends StatelessWidget {
  final Color color;
  final IconData icon;

  const _CoverTile({required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Icon(icon, color: AppColors.textSecondary, size: 13),
    );
  }
}

class _SeeAllRow extends StatelessWidget {
  const _SeeAllRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Text(
            'See all playlists',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Icon(Icons.chevron_right, color: AppColors.textMuted, size: 25),
      ],
    );
  }
}
