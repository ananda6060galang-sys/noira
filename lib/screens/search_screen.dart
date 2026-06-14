import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_placeholder.dart';
import '../widgets/search_category_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 142),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _TopBar(),
            SizedBox(height: 24),
            _SearchInput(),
            SizedBox(height: 32),
            _SectionHeader(title: 'Recent searches', trailing: 'Clear all'),
            SizedBox(height: 14),
            _RecentSearches(),
            SizedBox(height: 32),
            Text(
              'Browse Categories',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 14),
            _CategoryGrid(),
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
        const Expanded(
          child: Text(
            'Search',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ),
        const Icon(
          Icons.settings_outlined,
          color: AppColors.accentLight,
          size: 22,
        ),
        const SizedBox(width: 14),
        Container(
          width: 32,
          height: 32,
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
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchInput extends StatelessWidget {
  const _SearchInput();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x264A454F)),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: AppColors.textSecondary, size: 22),
          SizedBox(width: 10),
          Text(
            'Artists, songs, or podcasts',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String trailing;

  const _SectionHeader({required this.title, required this.trailing});

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
            ),
          ),
        ),
        Text(
          trailing,
          style: const TextStyle(
            color: AppColors.accentLight,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _RecentSearches extends StatelessWidget {
  const _RecentSearches();

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Lorn', Icons.person_outline, true, Color(0xFF252025)),
      ('Night Drive', Icons.directions_car_outlined, false, Color(0xFF1C2630)),
      ('Moderat', Icons.person_outline, true, Color(0xFF29251C)),
    ];

    return SizedBox(
      height: 98,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 18),
        itemBuilder: (context, index) {
          final item = items[index];
          return SizedBox(
            width: 76,
            child: Column(
              children: [
                SizedBox(
                  width: 68,
                  height: 68,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(item.$3 ? 34 : 14),
                    child: GradientPlaceholder(
                      icon: item.$2,
                      radius: item.$3 ? 34 : 14,
                      colors: [item.$4, AppColors.surfaceLow],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.$1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid();

  @override
  Widget build(BuildContext context) {
    const categories = [
      ('Chill', Icons.bedtime_outlined, Color(0xFFD6BAFF)),
      ('Sad', Icons.water_drop_outlined, Color(0xFFAFC7D6)),
      ('Focus', Icons.center_focus_strong, Color(0xFFD6C28F)),
      ('Night Drive', Icons.directions_car_outlined, Color(0xFF9EC7B3)),
      ('R&B', Icons.music_note, Color(0xFFC8C5CB)),
      ('Pop', Icons.bolt_outlined, Color(0xFFFFB4AB)),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 112,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return SearchCategoryCard(
          title: category.$1,
          icon: category.$2,
          accent: category.$3,
        );
      },
    );
  }
}
