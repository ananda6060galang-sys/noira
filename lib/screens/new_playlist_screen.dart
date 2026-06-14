import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NewPlaylistScreen extends StatefulWidget {
  const NewPlaylistScreen({super.key});

  @override
  State<NewPlaylistScreen> createState() => _NewPlaylistScreenState();
}

class _NewPlaylistScreenState extends State<NewPlaylistScreen> {
  bool _isPrivate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 138),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _TopBar(),
              const SizedBox(height: 18),
              const _CoverPicker(),
              const SizedBox(height: 24),
              const _FieldLabel('PLAYLIST TITLE'),
              const SizedBox(height: 10),
              const _InputBox(hint: 'Enter name...'),
              const SizedBox(height: 18),
              const _FieldLabel('DESCRIPTION'),
              const SizedBox(height: 10),
              const _InputBox(
                hint: 'Tell the story of this collection...',
                height: 86,
                maxLines: 4,
              ),
              const SizedBox(height: 18),
              _PrivateSwitch(
                value: _isPrivate,
                onChanged: (value) => setState(() => _isPrivate = value),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primaryContainer,
                    foregroundColor: AppColors.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34),
                    ),
                  ),
                  child: const Text(
                    'Create Playlist',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const _AddSongsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddSongsSection extends StatelessWidget {
  const _AddSongsSection();

  static const _songs = [
    ('Midnight City', 'M83', Icons.blur_on),
    ('Soft Spot', 'keshi', Icons.nightlight_outlined),
    ('Opera House', 'Cigarettes After Sex', Icons.album_outlined),
    ('Low Tide', 'Nova Blur', Icons.waves_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Expanded(child: _FieldLabel('ADD SONGS')),
            Text(
              'Recommended',
              style: TextStyle(
                color: AppColors.accentLight,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Row(
            children: [
              Icon(Icons.search, color: AppColors.textMuted, size: 18),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Search songs or artists',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF59545E),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        for (final song in _songs)
          _RecommendedSongTile(title: song.$1, artist: song.$2, icon: song.$3),
      ],
    );
  }
}

class _RecommendedSongTile extends StatelessWidget {
  final String title;
  final String artist;
  final IconData icon;

  const _RecommendedSongTile({
    required this.title,
    required this.artist,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF2A2A35)),
            ),
            child: Icon(icon, color: AppColors.textSecondary, size: 18),
          ),
          const SizedBox(width: 12),
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
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryContainer),
            ),
            child: const Icon(
              Icons.add,
              color: AppColors.primaryContainer,
              size: 18,
            ),
          ),
        ],
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
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: const SizedBox(
            width: 36,
            height: 36,
            child: Icon(
              Icons.arrow_back,
              color: AppColors.accentLight,
              size: 28,
            ),
          ),
        ),
        const SizedBox(width: 18),
        const Expanded(
          child: Text(
            'New Playlist',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
        ),
        const Icon(
          Icons.settings_outlined,
          color: AppColors.accentLight,
          size: 30,
        ),
      ],
    );
  }
}

class _CoverPicker extends StatelessWidget {
  const _CoverPicker();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 148,
        height: 148,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF111114),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF25252B)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(child: CustomPaint(painter: _WaveformPainter())),
              const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    color: AppColors.textSecondary,
                    size: 26,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Upload Cover',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height * 0.5;
    final linePaint = Paint()
      ..color = AppColors.accentLight.withValues(alpha: 0.18)
      ..strokeWidth = 2;
    final wavePaint = Paint()
      ..color = AppColors.accentLight.withValues(alpha: 0.055)
      ..style = PaintingStyle.fill;

    final path = Path()..moveTo(0, centerY);
    for (var x = 0.0; x <= size.width; x += 7) {
      final normalized = x / size.width;
      final amp =
          (math.sin(normalized * math.pi * 20).abs() * 0.55 +
              math.sin(normalized * math.pi * 47).abs() * 0.45) *
          size.height *
          0.22;
      path.lineTo(x, centerY - amp);
    }
    for (var x = size.width; x >= 0; x -= 7) {
      final normalized = x / size.width;
      final amp =
          (math.sin(normalized * math.pi * 20).abs() * 0.55 +
              math.sin(normalized * math.pi * 47).abs() * 0.45) *
          size.height *
          0.22;
      path.lineTo(x, centerY + amp);
    }
    path.close();

    canvas.drawPath(path, wavePaint);
    canvas.drawLine(Offset(0, centerY), Offset(size.width, centerY), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.6,
      ),
    );
  }
}

class _InputBox extends StatelessWidget {
  final String hint;
  final double height;
  final int maxLines;

  const _InputBox({required this.hint, this.height = 48, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        maxLines: maxLines,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
        cursorColor: AppColors.primaryContainer,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.surfaceContainer,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFF59545E),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 13,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.accentDark),
          ),
        ),
      ),
    );
  }
}

class _PrivateSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _PrivateSwitch({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Private Playlist',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Only you can view this',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.onPrimary,
            activeTrackColor: AppColors.primaryContainer,
            inactiveThumbColor: AppColors.textMuted,
            inactiveTrackColor: AppColors.surfaceHighest,
          ),
        ],
      ),
    );
  }
}
