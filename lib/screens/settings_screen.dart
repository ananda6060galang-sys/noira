import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _items = [
    'Account',
    'Data Saver',
    'Languages',
    'Playback',
    'Explicit Content',
    'Devices',
    'Privacy',
    'Notifications',
    'Audio Quality',
    'Storage',
    'About Noira',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _SettingsTopBar(onBack: () => Navigator.of(context).pop()),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
                children: [
                  const _ProfileEntry(),
                  const SizedBox(height: 34),
                  for (final item in _items) _SettingsTile(title: item),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTopBar extends StatelessWidget {
  final VoidCallback onBack;

  const _SettingsTopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Stack(
        children: [
          Positioned(
            left: 6,
            top: 9,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onBack,
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.chevron_left,
                  color: AppColors.textSecondary,
                  size: 28,
                ),
              ),
            ),
          ),
          const Center(
            child: Text(
              'Settings',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileEntry extends StatelessWidget {
  const _ProfileEntry();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceContainer,
            border: Border.all(color: const Color(0xFF332941)),
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Text(
              'G',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'galang',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'View Profile',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 26),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;

  const _SettingsTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 27),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 24),
        ],
      ),
    );
  }
}
