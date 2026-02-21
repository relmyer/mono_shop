import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../models/category.dart';
import '../widgets/app_search_bar.dart';
import '../widgets/home_banner.dart';
import '../widgets/category_grid.dart';
import '../widgets/product_grid.dart';
import '../widgets/bottom_nav.dart';
import '../../../shared/widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _repo = ProductRepository();
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final recommended = _repo.getRecommended(limit: 6);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenH,
                AppSpacing.lg,
                AppSpacing.screenH,
                AppSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good morning! 👋',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                          Text(
                            'Find Your Style',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Notification bell
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.iconBtnRadius),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Stack(
                          children: [
                            const Center(
                              child: Icon(
                                Icons.notifications_outlined,
                                color: AppColors.textPrimary,
                                size: 22,
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppSearchBar(
                    readOnly: true,
                    onTap: () => context.push('/catalog'),
                    onCartTap: () {},
                  ),
                ],
              ),
            ),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenH),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    // Banner
                    const HomeBanner(),
                    const SizedBox(height: AppSpacing.xl),
                    // Categories
                    SectionHeader(
                      title: 'Categories',
                      actionLabel: 'See all',
                      onActionTap: () => context.push('/catalog'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    CategoryGrid(
                      onCategoryTap: (Category cat) {
                        context.push('/catalog', extra: cat.name);
                      },
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    // Recommended
                    SectionHeader(
                      title: 'Recommended',
                      actionLabel: 'See more',
                      onActionTap: () => context.push('/catalog'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ProductGrid(products: recommended),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: (index) {
          if (index == 1) {
            context.push('/catalog');
          } else {
            setState(() => _navIndex = index);
          }
        },
      ),
    );
  }
}
