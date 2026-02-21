import 'package:flutter/material.dart';
import '../../../core/theme/app_text.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../models/category.dart';

class CategoryGrid extends StatelessWidget {
  final ValueChanged<Category>? onCategoryTap;

  const CategoryGrid({super.key, this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryData.all;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.85,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        return _CategoryItem(
          category: cat,
          onTap: () => onCategoryTap?.call(cat),
        );
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const _CategoryItem({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: category.bgColor,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(
              category.icon,
              size: 28,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            category.name,
            style: AppText.caption,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
