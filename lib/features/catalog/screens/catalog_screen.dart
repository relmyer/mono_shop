import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../models/product.dart';
import '../widgets/app_search_bar.dart';
import '../widgets/category_chip_row.dart';
import '../widgets/product_grid.dart';
import '../widgets/bottom_nav.dart';

enum SortTab { popular, latest, bestSellers, price }

class CatalogScreen extends StatefulWidget {
  final String? initialCategory;

  const CatalogScreen({super.key, this.initialCategory});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen>
    with SingleTickerProviderStateMixin {
  final _repo = ProductRepository();
  final _searchController = TextEditingController();

  SortTab _currentTab = SortTab.popular;
  String _selectedChip = 'All';
  List<Product> _products = [];
  bool _showSearch = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    List<Product> base;
    switch (_currentTab) {
      case SortTab.popular:
        base = _repo.getRecommended(limit: 12);
      case SortTab.latest:
        base = _repo.getLatest(limit: 12);
      case SortTab.bestSellers:
        base = _repo.getBestSellers(limit: 12);
      case SortTab.price:
        base = _repo.getByPriceAsc(limit: 12);
    }

    if (_selectedChip != 'All') {
      base = base.where((p) => p.category == _selectedChip).toList();
      if (base.isEmpty) base = _repo.getAll();
    }

    setState(() => _products = base);
  }

  void _onSearch(String query) {
    if (query.isEmpty) {
      _loadProducts();
    } else {
      setState(() => _products = _repo.search(query));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            _buildTabRow(),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
              child: CategoryChipRow(
                initialSelected: _selectedChip,
                onSelected: (chip) {
                  _selectedChip = chip;
                  _loadProducts();
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: _products.isEmpty
                  ? const Center(
                      child: Text('No products found'),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.screenH),
                      child: Column(
                        children: [
                          ProductGrid(products: _products),
                          const SizedBox(height: AppSpacing.xl),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onTap: (index) {
          if (index != 1) Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.screenH,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
            color: AppColors.textPrimary,
            onPressed: () => Navigator.of(context).pop(),
          ),
          // Title or Search
          Expanded(
            child: _showSearch
                ? AppSearchBar(
                    controller: _searchController,
                    onChanged: _onSearch,
                    onCartTap: () {},
                  )
                : Text('Catalog', style: AppText.h3),
          ),
          // Search toggle
          if (!_showSearch) ...[
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: () => setState(() => _showSearch = true),
              child: _iconBox(Icons.search_rounded),
            ),
          ] else ...[
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showSearch = false;
                  _searchController.clear();
                });
                _loadProducts();
              },
              child: _iconBox(Icons.close_rounded),
            ),
          ],
          const SizedBox(width: AppSpacing.sm),
          // Filter button
          GestureDetector(
            onTap: _showFilterSheet,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.iconBtnRadius),
                border: Border.all(color: AppColors.border),
              ),
              child: const Row(
                children: [
                  Icon(Icons.tune_rounded,
                      size: 18, color: AppColors.textPrimary),
                  SizedBox(width: 4),
                  Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBox(IconData icon) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.iconBtnRadius),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, size: 20, color: AppColors.textPrimary),
      );

  Widget _buildTabRow() {
    final tabs = ['Popular', 'Latest', 'Best Sellers', 'Price'];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xl),
        itemBuilder: (context, index) {
          final tab = SortTab.values[index];
          final isSelected = tab == _currentTab;
          return GestureDetector(
            onTap: () {
              setState(() => _currentTab = tab);
              _loadProducts();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tabs[index],
                  style: AppText.labelLg.copyWith(
                    color: isSelected
                        ? AppColors.textPrimary
                        : AppColors.textMuted,
                    fontWeight: isSelected
                        ? FontWeight.w700
                        : FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                if (isSelected)
                  Container(
                    height: 3,
                    width: 20,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Filter', style: AppText.h3),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Reset',
                    style: AppText.labelMd
                        .copyWith(color: AppColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Price Range', style: AppText.h3.copyWith(fontSize: 16)),
            const SizedBox(height: AppSpacing.sm),
            const Text('\$0  ─────────────────────  \$1000'),
            const SizedBox(height: AppSpacing.xl),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
                child: const Text(
                  'Apply Filter',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}
