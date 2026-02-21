import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../core/theme/app_spacing.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int _currentIndex = 0;

  final List<_BannerData> _banners = const [
    _BannerData(
      title: 'New Arrivals\nThis Season',
      subtitle: 'Up to 40% Off',
      discount: '40% OFF',
      buttonLabel: 'Shop Now',
      gradient: LinearGradient(
        colors: [Color(0xFFE84D4D), Color(0xFFFF7070)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300&q=80',
    ),
    _BannerData(
      title: 'Summer Sale\nCollection',
      subtitle: 'Premium Brands',
      discount: '30% OFF',
      buttonLabel: 'Explore',
      gradient: LinearGradient(
        colors: [Color(0xFF5B7FFF), Color(0xFF7B9FFF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      imageUrl:
          'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=300&q=80',
    ),
    _BannerData(
      title: 'Flash Deals\nToday Only',
      subtitle: 'Limited Time',
      discount: '50% OFF',
      buttonLabel: 'Grab Now',
      gradient: LinearGradient(
        colors: [Color(0xFF2ECC71), Color(0xFF1ABC9C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      imageUrl:
          'https://images.unsplash.com/photo-1607522370275-f6fd21dd99cc?w=300&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            itemCount: _banners.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (context, index) =>
                _BannerCard(data: _banners[index]),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == _currentIndex ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: i == _currentIndex
                    ? AppColors.primary
                    : AppColors.border,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BannerData {
  final String title;
  final String subtitle;
  final String discount;
  final String buttonLabel;
  final LinearGradient gradient;
  final String imageUrl;

  const _BannerData({
    required this.title,
    required this.subtitle,
    required this.discount,
    required this.buttonLabel,
    required this.gradient,
    required this.imageUrl,
  });
}

class _BannerCard extends StatelessWidget {
  final _BannerData data;

  const _BannerCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        gradient: data.gradient,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Stack(
          children: [
            // Background pattern circles
            Positioned(
              right: -20,
              top: -30,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(25),
                ),
              ),
            ),
            Positioned(
              right: 60,
              bottom: -40,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(15),
                ),
              ),
            ),
            // Product image
            Positioned(
              right: 12,
              bottom: 0,
              top: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  data.imageUrl,
                  width: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(width: 130),
                ),
              ),
            ),
            // Text content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Discount badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    child: Text(
                      data.discount,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    data.title,
                    style: AppText.h2.copyWith(
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    data.subtitle,
                    style: AppText.bodySm.copyWith(
                      color: Colors.white.withAlpha(204),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    child: Text(
                      data.buttonLabel,
                      style: AppText.labelSm.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
